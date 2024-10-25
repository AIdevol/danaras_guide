import 'dart:io';

import 'package:banaras_guide/model/login_response_model.dart';
import 'package:banaras_guide/model/register_response_model.dart';
import 'package:banaras_guide/services/auth/api_ends.dart';
import 'package:banaras_guide/services/auth/auth_abstract_method.dart';
import 'package:banaras_guide/services/dio_client.dart';
import 'package:banaras_guide/services/network_exception.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppAuthencticationMethod extends GetxService
    implements AuthAbstractMethodApi {
  late ApiClient? dioClient;
  var deviceName, deviceType, deviceID;

  Dio dio = Dio();

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = androidDeviceInfo.model;
      deviceID = androidDeviceInfo.device;
      deviceType = "1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.model;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceType = "2";
    }
  }

  @override
  void onInit() {
    super.onInit();
    var dio = Dio();
    dioClient = ApiClient(baseUrl: ApIEnds.baseUrl, dio: dio);
    getDeviceData();
  }

@override
  Future<RegisterResponseModel> signUpAuhtAPiCall({Map<String, dynamic>? dataBody})async {
    try {
      final response = await dioClient?.post("${ApIEnds.signup}", data: dataBody);
      return RegisterResponseModel.fromJson(response);
    } catch (error) {
      return Future.error(NetworkException.getDioException(error));
    }
  }
@override
  Future<LoginResponseModel> loginAuhtAPiCall({Map<String, dynamic>? dataBody})async {
    try {
      final response = await dioClient?.post("${ApIEnds.login}", data: dataBody);
      return LoginResponseModel.fromJson(response);
    } catch (error) {
      return Future.error(NetworkException.getDioException(error));
    }
  }
}
