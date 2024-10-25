import 'package:banaras_guide/model/login_response_model.dart';
import 'package:banaras_guide/model/register_response_model.dart';

abstract class AuthAbstractMethodApi {
  Future<RegisterResponseModel> signUpAuhtAPiCall(
      {Map<String, dynamic>? dataBody});
  Future<LoginResponseModel> loginAuhtAPiCall({Map<String, dynamic>? dataBody});
}
