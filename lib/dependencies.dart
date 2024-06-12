import 'package:dchat/infrastructure/provider/chats/gql_rooms_provider.dart';
import 'package:dchat/infrastructure/provider/rooms_provider.dart';
import 'package:dchat/infrastructure/repository/chat_ropsitory.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void registerDependencies() {
  serviceLocator.registerLazySingleton<ChatProvider>(
    () => ChatGQLProvider(),
  );

  serviceLocator.registerLazySingleton<ChatRepository>(
    () => ChatRepository(
      chatProvider: serviceLocator(),
    ),
  );
}
