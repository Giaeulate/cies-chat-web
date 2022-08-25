import 'package:cies_web_socket/api/login_service.dart';
import 'package:cies_web_socket/global/custom_alert.dart';
import 'package:cies_web_socket/global/local_storage.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthProvider extends ChangeNotifier {
  String? _refresh;
  String? _access;

  bool _checkRemember = false, _loading = false;

  String? get refresh => _refresh;
  String? get access => _access;

  bool get checkRemember => _checkRemember;
  set checkRemember(bool val) {
    _checkRemember = val;
    notifyListeners();
  }

  bool get loading => _loading;
  set loading(bool val) {
    _loading = val;
    notifyListeners();
  }

  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    Future.delayed(const Duration(seconds: 1), () => isAuthenticated());
  }

  deleteCredencial() async {
    await LocalStorage.sharedPreferences.clear();
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

  saveLocalStorageCredential(dynamic resp) async {
    await LocalStorage.sharedPreferences.setString('refresh', resp["refresh"]);
  }

  login(BuildContext context, String user, String password) async {
    showCustomAlertLoading(context);
    bool resp = await loginService(user, password);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    if (!resp) {
      // ignore: use_build_context_synchronously
      showCustomAlert(context, "Error", "Usuario o contraseña incorrectos");
      return;
    }
    authStatus = AuthStatus.authenticated;
    notifyListeners();
  }

  Future<bool> isAuthenticated() async {
    authStatus = AuthStatus.checking;
    final refresh = LocalStorage.sharedPreferences.getString('refresh');
    final access = LocalStorage.sharedPreferences.getString('access');
    if (refresh == null || access == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    await Future.delayed(const Duration(seconds: 1));
    _refresh = refresh;
    _access = access;
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }
}
