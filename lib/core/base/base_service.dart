import 'package:login/core/service/http_request.dart';
import 'package:login/core/service/http_response.dart';

abstract class BaseService {

  final String server = "http://192.168.0.15:8084/";

  Future getResponse(HTTPRequest request, Function(HTTPResponse) success, Function(HTTPResponse) error);

}