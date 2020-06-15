import 'package:get_it/get_it.dart';
import 'package:hello_world/ui/user/services/push_notifications_service.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => PushNotificationService());
}