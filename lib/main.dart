import 'package:cies_web_socket/global/local_storage.dart';
import 'package:cies_web_socket/src/web/main_web.dart';
import 'package:cies_web_socket/src/web/provider/auth_provider.dart';
import 'package:cies_web_socket/src/web/router/router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() async {
  await LocalStorage.configurePreferences();
  Flurorouter.configureRoutes();
  if (kIsWeb) {
    runApp(const AppState(MyWeb()));
    // } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    // runApp(const AppState(child: MyDesktop()));
  }
}

class AppState extends StatelessWidget {
  final Widget child;
  const AppState(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => AuthProvider(),
        ),
      ],
      child: child,
    );
  }
}
