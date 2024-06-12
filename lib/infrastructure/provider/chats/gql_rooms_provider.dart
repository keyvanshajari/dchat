import 'package:dchat/common/network/remote_data_provider.dart';
import 'package:dchat/infrastructure/provider/rooms_provider.dart';
import 'package:dchat/presentation/rooms/rooms_controller.dart';
import 'package:graphql/client.dart';

class ChatGQLProvider extends ChatProvider {
  final client = RemoteDataProvider.instance.client;
  @override
  Stream<QueryResult<Object?>> getLatestMessage() {
    try {
      final subscription = client.subscribe(
        SubscriptionOptions(
          document: gql('''
subscription subsss {
  messages(
    where: {
    _or: [
    {receiver_id: {_eq: "$myUserId"}},
    {sender_id: {_eq: "$myUserId"}}
     ]}
    order_by: {created_at: desc}
    limit: 1
  ) {
    content
    id
    receiver_id
    sender_id
    user {
      id
      full_name
      email
    }
    userBySenderId {
      id
      full_name
      email
    }
    created_at
    }
      }
      '''),
        ),
      );
      return subscription;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getChatHistorybyId({
    required String id,
    required int offset,
  }) async {
    try {
      final result = await client.query(
        QueryOptions(
          document: gql('''
query MyQuery {
  messages(
   where: {
  
      _or: [
        {
          _and:[
      {receiver_id: {_eq: "$myUserId"}},
      {sender_id: {_eq: "$id"}},        
          ]
        },
        {
          _and:[
    {receiver_id: {_eq: "$id"}},
    {sender_id: {_eq: "$myUserId"}},        
          ]
        }
    
     ]


     }
     
    order_by: {created_at: desc}
    limit: 10
    offset: $offset
  ) {
    content
    id
    receiver_id
    sender_id
    user {
      id
      full_name
      email
    }
    userBySenderId {
      id
      full_name
      email
    }
    created_at
  }
}

'''),
        ),
      );
      if (result.hasException) throw const ServerException();

      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendMessage({
    required String content,
    required String receiverId,
  }) async {
    try {
      final result = await client.mutate(
        MutationOptions(
          document: gql('''
mutation MyMutation {

  insert_messages_one(
    object: {receiver_id: "$receiverId", sender_id: "$myUserId", content: "$content"}
  ) {
    id
    sender_id
    receiver_id
    content
  }        
  }
          '''),
        ),
      );
      if (result.hasException) throw const ServerException();
    } catch (e) {
      rethrow;
    }
  }
}
