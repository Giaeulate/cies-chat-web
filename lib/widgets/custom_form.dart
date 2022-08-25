import 'package:cies_web_socket/src/web/provider/login_form_provider.dart';
import 'package:cies_web_socket/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomForm extends StatelessWidget {
  final List<Widget> children;
  final Function() onPress;
  const CustomForm({
    Key? key,
    required this.children,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(builder: (context) {
        final loginFormProvider =
            Provider.of<LoginFormProvider>(context, listen: false);
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: Form(
            key: loginFormProvider.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...children,
                const SizedBox(height: 30),
                CustomButtonWidget(
                  text: "Aceptar",
                  onPress: () =>
                      loginFormProvider.validateForm() ? onPress() : null,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
