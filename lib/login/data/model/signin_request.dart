import 'package:json_annotation/json_annotation.dart';
import 'package:login/login/domain/model/user_model.dart';
part 'signin_request.g.dart';

@JsonSerializable()
class SigninRequest {
  late UserModel user;

  SigninRequest(this.user);

  factory SigninRequest.fromJson(Map<String, dynamic> json) => _$SigninRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SigninRequestToJson(this);
}