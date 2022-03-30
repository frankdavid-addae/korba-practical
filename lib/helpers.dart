import 'package:get_it/get_it.dart';
import 'package:korba_practical/services/shared_preference_store.dart';

class Helpers {
  static int get timeOutSeconds => 30;

  static int get milliSeconds => 500;

  static void signOut() async {
    final _sharedPrefStore = GetIt.I.get<SharedPrefStore>();
    await _sharedPrefStore.removeStoredData('token');
    await _sharedPrefStore.removeStoredData('authUserData');
    await _sharedPrefStore.removeAll();
  }
}
