import 'package:cies_web_socket/global/navigation_service.dart';
import 'package:cies_web_socket/src/web/Layout/auth_layout.dart';
import 'package:cies_web_socket/src/web/Layout/dashboard_layout.dart';
import 'package:cies_web_socket/src/web/Layout/splash_layout.dart';
import 'package:cies_web_socket/src/web/provider/auth_provider.dart';
import 'package:cies_web_socket/src/web/provider/login_form_provider.dart';
import 'package:cies_web_socket/src/web/router/router.dart';
import 'package:cies_web_socket/widgets/custom_scroll.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyWeb extends StatelessWidget {
  const MyWeb({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => LoginFormProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Cies Web',
        initialRoute: '/',
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigateKey,
        builder: (_, child) {
          final authProvider = Provider.of<AuthProvider>(context);
          if (authProvider.authStatus == AuthStatus.checking) {
            return const SplashLayout();
          }
          if (authProvider.authStatus == AuthStatus.authenticated) {
            // final socketService = Provider.of<SocketService>(context);
            // if (!socketService.initSocket) {
            //   socketService.initConfig(authProvider.access!);
            // }
            return DashboardLayout(child: child!);
          } else {
            return AuthLayout(child: child!);
          }
        },
        theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
            thumbColor: MaterialStateProperty.all(
              Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
