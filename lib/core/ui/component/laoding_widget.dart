import 'package:flutter/material.dart';
import 'package:login/login/presentation/login_view_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginInitialWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginInitialWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginInitialWidgetState createState() => _LoginInitialWidgetState();
}

class _LoginInitialWidgetState extends State<LoginInitialWidget> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Stack(
        children: const [
          Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage('./assets/checkredflag.gif'),
              height: 50.0,
              width: 50.0,
            ),
          )
        ],
      );
    });
  }
}
