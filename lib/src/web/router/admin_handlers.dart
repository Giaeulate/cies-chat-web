import 'package:cies_web_socket/src/web/provider/auth_provider.dart';
import 'package:cies_web_socket/src/web/views/home_view.dart';
import 'package:cies_web_socket/src/web/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    // final sidebarProvider = Provider.of<SidebarProvider>(context);

    // Future.delayed(
    //   const Duration(milliseconds: 1),
    //   () => sidebarProvider.menuSelected = 0,
    // );

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const HomeView();
    }
    return const LoginView();
  });
}
