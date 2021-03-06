

import 'package:login/login/domain/model/bearer_token_model.dart';
import 'package:login/login/domain/model/keychain_model.dart';
import 'package:login/login/domain/model/public_key_model.dart';
import 'package:login/login/domain/model/user_model.dart';

class Session{

  static UserModel? _userModel;
  static KeyChainModel? _keyChain;
  static PublicKeyModel? _publicKeyModel;
  static BearerTokenModel? _bearerTokenModel;

  Session._();

  static Session? _instance;

  static Session get instance {
    return _instance = Session._();
  }

  static void dispose() {
    _instance = null;
  }

  void setUser(UserModel userModel){
    _userModel = userModel;
  }

  UserModel? getUser(){
    return _userModel;
  }

  void setRSAKey(PublicKeyModel publicKeyModel){
    _publicKeyModel = publicKeyModel;
  }

  PublicKeyModel? getRSAKey() {
    return _publicKeyModel;
  }

  void setKeyChain(KeyChainModel? keyChain){
    _keyChain = keyChain;
  }

  KeyChainModel? getKeyChain(){
    return _keyChain;
  }

  void setBearerToken(BearerTokenModel? bearerTokenModel){
    _bearerTokenModel = bearerTokenModel;
  }

  BearerTokenModel? getBearerToken(){
    return _bearerTokenModel;
  }

}