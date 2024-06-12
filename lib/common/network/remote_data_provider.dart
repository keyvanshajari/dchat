import 'dart:async';

import 'package:dchat/common/network/exception.dart';
import 'package:dchat/common/services/environment_service.dart';
import 'package:graphql/client.dart' hide ServerException;

class RemoteDataProvider {
  static final RemoteDataProvider instance = RemoteDataProvider._();
  RemoteDataProvider._();
  factory RemoteDataProvider() {
    return instance;
  }

  String get _graphqlUrl => EnvironmentService().config.graphqlUrl;
  String get _graphqlSocketUrl => EnvironmentService().config.websocketUrl;
  HttpLink get _httpLink => HttpLink(_graphqlUrl);
  AuthLink get _authLink => AuthLink(
        getToken: () async =>
            'Hapoooli@20290', // it should move to secret config
        headerKey: 'x-hasura-admin-secret',
      );

  Link get _link {
    final link = _authLink.concat(_httpLink);
    final wsLink = WebSocketLink(_graphqlSocketUrl);
    return Link.split((request) => request.isSubscription, wsLink, link);
  }

  GraphQLClient get client => GraphQLClient(
        cache: GraphQLCache(),
        link: _link,
      );

  void handleError(QueryResult result) {
    if (result.hasException) {
      if (result.exception?.graphqlErrors != null &&
          result.exception!.graphqlErrors.isNotEmpty &&
          result.exception!.graphqlErrors.any((element) =>
              element.extensions?['code'] == 'UNAUTHORIZED_ERROR')) {
        throw UnauthorizedException(message: 'User is not authorized');
      }
      final message = result.exception!.graphqlErrors.isNotEmpty
          ? result.exception!.graphqlErrors.first.message
          : 'Unknown error';
      final code = result.exception!.graphqlErrors
          .map((e) => e.extensions?['code'] ?? 'UNKNOWN_CODE')
          .join('|');

      throw ServerException(message: message, code: code);
    }
  }

  Future<QueryResult<T>> query<T>(QueryOptions<T> options,
      [Duration? timeLimit = const Duration(seconds: 8)]) async {
    Future<QueryResult<T>> future = client.query<T>(options);

    if (timeLimit != null) {
      future = future.timeout(timeLimit);
    }

    try {
      final result = await future;

      handleError(result);

      return result;
    } on TimeoutException {
      throw ServerException(
        message: 'Request timed out',
        code: 'TIMEOUT',
        data: options,
      );
    }
  }

  Future<QueryResult<T>> mutate<T>(MutationOptions<T> options,
      [Duration? timeLimit = const Duration(seconds: 8)]) async {
    Future<QueryResult<T>> future = client.mutate<T>(options);

    if (timeLimit != null) {
      future = future.timeout(timeLimit);
    }

    final result = await future;

    handleError(result);

    return result;
  }

  Future<QueryResult<T>> fetchMore<T>(
    FetchMoreOptions fetchMoreOptions, {
    required QueryOptions<T> originalOptions,
    required QueryResult<T> previousResult,
  }) =>
      client.fetchMore<T>(
        fetchMoreOptions,
        originalOptions: originalOptions,
        previousResult: previousResult,
      );

  ObservableQuery<T> watchQuery<T>(WatchQueryOptions<T> options) =>
      client.watchQuery<T>(options);

  ObservableQuery<T> watchMutation<T>(WatchQueryOptions<T> options) =>
      client.watchMutation<T>(options);

  Stream<QueryResult<T>> subscribe<T>(SubscriptionOptions<T> options) =>
      client.subscribe<T>(options);

  void writeQuery(Request request, {required data, broadcast = true}) =>
      client.writeQuery(request, data: data, broadcast: broadcast);

  Map<String, dynamic>? readQuery(Request request, {optimistic = true}) =>
      client.readQuery(request, optimistic: optimistic);

  void writeFragment(
    FragmentRequest fragmentRequest, {
    broadcast = true,
    required data,
  }) =>
      client.writeFragment(fragmentRequest, data: data, broadcast: broadcast);

  Map<String, dynamic>? readFragment(
    FragmentRequest fragmentRequest, {
    optimistic = true,
  }) =>
      client.readFragment(fragmentRequest, optimistic: optimistic);
}
