import 'package:get/get.dart';
import 'package:m_commerce/app/urls.dart';
import 'package:m_commerce/features/auth/data/models/sign_in_model.dart';
import 'package:m_commerce/features/common/ui/controllers/auth_controller.dart';
import 'package:m_commerce/service/network/network_caller.dart';
import 'package:m_commerce/service/network/network_response.dart';

class SignInController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.signIn, body);
    if (response.isSuccess) {
      SignInModel signInModel =
          SignInModel.fromJson(response.responseData["data"]);
      await Get.find<AuthController>()
          .saveUserData(signInModel.token!, signInModel.user!);
      isSuccess = true;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
