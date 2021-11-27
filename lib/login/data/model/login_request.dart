import 'package:json_annotation/json_annotation.dart';
import 'package:login/login/domain/model/keychain_model.dart';
part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  late String email;
  late String password;
  late KeyChainModel keyChain;

  LoginRequest(this.email, this.password, this.keyChain);

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}