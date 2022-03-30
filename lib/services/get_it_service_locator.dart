import 'package:get_it/get_it.dart';
import 'package:korba_practical/classes/feedback_dialogs.dart';
import 'package:korba_practical/services/auth_api_requests.dart';
import 'package:korba_practical/services/shared_preference_store.dart';

void setUpGetItServiceLocator() {
  // GetIt.I.registerSingleton<DynamicLinksAPI>(DynamicLinksAPI());
  //this is coming from API so I used lazy
  GetIt.I.registerSingleton<FeedbackDialog>(FeedbackDialog());
  GetIt.I.registerSingleton<SharedPrefStore>(SharedPrefStore());
  GetIt.I.registerLazySingleton<AuthApiRequest>(() => AuthApiRequest());
}
