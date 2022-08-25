import 'package:cies_web_socket/src/web/provider/auth_provider.dart';
import 'package:cies_web_socket/src/web/provider/login_form_provider.dart';
import 'package:cies_web_socket/theme/theme_app.dart';
import 'package:cies_web_socket/widgets/custom_button_widget.dart';
import 'package:cies_web_socket/widgets/custom_input_widget.dart';
import 'package:cies_web_socket/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  _login(
    AuthProvider authProvider,
    LoginFormProvider loginFormProvider,
    BuildContext context,
  ) {
    if (loginFormProvider.validateForm()) {
      authProvider.login(
        context,
        loginFormProvider.user,
        loginFormProvider.password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      height: size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 60.0,
          bottom: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/cies-logo.svg',
              width: 220.0,
            ),
            Builder(builder: (context) {
              final loginFormProvider =
                  Provider.of<LoginFormProvider>(context, listen: false);
              return SizedBox(
                width: size.width,
                height: size.height,
                child: Form(
                  key: loginFormProvider.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 350),
                        child: Column(
                          children: [
                            CustomInputWidget(
                              fillColor: Colors.white.withOpacity(0.5),
                              validate: true,
                              onChange: (val) => loginFormProvider.user = val,
                              onSubmit: (val) => _login(
                                  authProvider, loginFormProvider, context),
                              hint: "Usuario",
                              borderSideOff:
                                  BorderSide(color: ThemeApp.borderColor),
                              borderSideOn:
                                  BorderSide(color: ThemeApp.borderColor),
                              borderRadius: BorderRadius.circular(18),
                              textAlign: TextAlign.start,
                              hintColor: ThemeApp.primaryLogin.withOpacity(0.5),
                            ),
                            const SizedBox(height: 20),
                            CustomInputWidget(
                              fillColor: Colors.white.withOpacity(0.5),
                              onSubmit: (val) => _login(
                                  authProvider, loginFormProvider, context),
                              validate: true,
                              onChange: (val) =>
                                  loginFormProvider.password = val,
                              hint: "Contraseña",
                              isPass: true,
                              borderSideOff:
                                  BorderSide(color: ThemeApp.borderColor),
                              borderSideOn:
                                  BorderSide(color: ThemeApp.borderColor),
                              borderRadius: BorderRadius.circular(18),
                              textAlign: TextAlign.start,
                              hintColor: ThemeApp.primaryLogin.withOpacity(0.5),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                      authProvider.loading
                          ? const CustomLoading()
                          : CustomButtonWidget(
                              text: "Login",
                              bgColor: Colors.orange,
                              textColor: Colors.white,
                              onPress: () => _login(
                                  authProvider, loginFormProvider, context),
                            ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
