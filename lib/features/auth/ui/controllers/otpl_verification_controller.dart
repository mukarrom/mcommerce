import 'package:get/get.dart';
import 'package:m_commerce/app/urls.dart';
import 'package:m_commerce/features/auth/data/models/sign_in_model.dart';
import 'package:m_commerce/features/common/ui/controllers/auth_controller.dart';
import 'package:m_commerce/service/network/network_caller.dart';
import 'package:m_commerce/service/network/network_response.dart';

class OtpVerificationController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;
  String? _token;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;

  Future<bool> verifyOtp(String email, String otp) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "otp": otp,
    };
    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(
      Urls.verifyOtp,
      requestBody,
    );
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      SignInModel signInModel = SignInModel.fromJson(response.responseData);
      // read profile data
      await Get.find<AuthController>().saveUserData(
        signInModel.token!,
        signInModel.user!,
      );
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
