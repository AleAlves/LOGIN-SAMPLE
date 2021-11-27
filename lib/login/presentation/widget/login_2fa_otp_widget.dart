import 'package:flutter/material.dart';
import 'package:login/core/ui/component/text/text_widget.dart';
import 'package:login/main.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../login_view_model.dart';

class Login2FAWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const Login2FAWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _Login2FAWidgetState createState() => _Login2FAWidgetState();
}

class _Login2FAWidgetState extends State<Login2FAWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextWidget("Second Step Verification", Style.description),
        const SizedBox(
          height: 24,
        ),
        OtpTextField(
          autoFocus: true,
          numberOfFields: 6,
          borderColor: MyApp.color,
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          //runs when every textfield is filled
          onSubmit: (String code){
            widget.viewModel.login2fa(code);
          }, // end onSubmit
        ),
        const SizedBox(
          height: 48,
        ),
        TextButton(
          onPressed: () {
            widget.viewModel.flow = LoginFlow.resetCode;
          },
          child: const Text("Não consigo acessar"),
        )
      ],
    );
  }
}
