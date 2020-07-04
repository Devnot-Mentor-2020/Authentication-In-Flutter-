import 'package:get_it/get_it.dart';
import 'package:naptin/repository/user_repo.dart';
import 'package:naptin/services/fake_auth_service.dart';
import 'package:naptin/services/firebase_auth_services.dart';
import 'package:naptin/services/firestore_db_services.dart';

GetIt locator=GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(()=> FireBaseAuthService());
  locator.registerLazySingleton(()=> FakeAuthService());
  locator.registerLazySingleton(()=> UserRepository());
  locator.registerLazySingleton(() => FirestoreDbServices());


}
