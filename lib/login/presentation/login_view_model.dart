import 'package:login/core/service/api_exception.dart';
import 'package:login/core/tools/session.dart';
import 'package:login/core/ui/view_state.dart';
import 'package:login/login/domain/login_interactor.dart';
import 'package:login/login/domain/model/status_model.dart';
import 'package:login/login/domain/model/user_model.dart';
import 'package:login/login/presentation/ui/login_flow.dart';
import 'package:mobx/mobx.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModel with _$LoginViewModel;

abstract class _LoginViewModel with Store {
  _LoginViewModel();

  @observable
  ViewState state = ViewState.loading;

  @observable
  LoginFlow flow = LoginFlow.initial ;

  @observable
  UserModel? user;

  @observable
  StatusModel? status;

  @observable
  String? otpQR;

  @observable
  bool loginAutomatically = true;

  final LoginInteractor _interactor = LoginInteractorImpl();

  @action
  init() async {
    state = ViewState.loading;
  }

  void getPublickey() async {
    await _interactor.getPublicKey((key) {
      Session.instance.setRSAKey(key);
      state = ViewState.ready;
      getUser();
    }, onError);
  }

  void login(String email, String password) async {
    state = ViewState.loading;

    await _interactor.login(email, password, (login) {

      Session.instance.setBearerToken(login.bearerToken);
      saveUser(email, password);

      if (login.required2FA) {
        state = ViewState.ready;
        flow = LoginFlow.login2fa;
      } else {
        status = StatusModel("Logged successfuly", "2FA", LoginFlow.toogle2fa);
        state = ViewState.ready;
        flow = LoginFlow.status;
      }
    }, onError);
  }

  void toogle2fa(bool value) async {
    state = ViewState.loading;

    await _interactor.toogle2FA((success) {
      state = ViewState.ready;
      var message = '';
      if (value) {
        message = "2FA habilitado";
      } else {
        message = "2FA desabilitado";
      }
      otpQR = success;
      status = StatusModel(message, "Ok", LoginFlow.otpQr);
      flow = LoginFlow.status;
    }, onError);
  }

  void login2fa(String code) async {

    state = ViewState.loading;

    await _interactor.login2FA(code, (success) {

      status = StatusModel("2FA Logged successfuly", "ok", LoginFlow.initial);
      state = ViewState.ready;
      flow = LoginFlow.status;
    }, onError);
  }

  void signin(String name, String mail, String password) async {
    state = ViewState.loading;

    await _interactor.signIn(name, mail, password, (success) {
      state = ViewState.ready;
      status = StatusModel("Conta criada com sucesso", "Ok", LoginFlow.login);
      flow = LoginFlow.status;
    }, onError);
  }

  void forgot(String mail) async {
    state = ViewState.loading;
    await _interactor.forgot(mail, () {
      state = ViewState.ready;
      status = StatusModel(
          "Enviamos um c??digo de verifica????o para o seu email ",
          "Ok",
          LoginFlow.reset);
      flow = LoginFlow.status;
    }, onError);
  }

  void reset(String mail, String password, String code) async {
    state = ViewState.loading;
    await _interactor.reset(mail, password, code, () {
      state = ViewState.ready;
      status = StatusModel("Senha resetada", "Ok", LoginFlow.login);
      flow = LoginFlow.status;
    }, onError);
  }

  void getUser() async {
    state = ViewState.ready;
    await _interactor.getUser(loadCurrentUser);
  }

  void loadCurrentUser(UserModel? userModel) {
    if (userModel != null) {
      flow = LoginFlow.login;
      user = userModel;
      if(loginAutomatically){
        login(userModel.profile?.email ?? '', userModel.auth?.password ?? '');
      }
    }
  }

  void saveUser(String email, String password) async {
    await _interactor.saveUser(email, password);
  }

  void onError(ApiException error) {
    state = ViewState.error;
  }

  void retry() {
    getPublickey();
  }
}
