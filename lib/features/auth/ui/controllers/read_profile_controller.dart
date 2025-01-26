import 'package:get/get.dart';
import 'package:m_commerce/app/urls.dart';
import 'package:m_commerce/features/auth/data/models/profile_model.dart';
import 'package:m_commerce/service/network/network_caller.dart';
import 'package:m_commerce/service/network/network_response.dart';

class ReadProfileController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;
  ProfileModel? _profileModel;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ProfileModel? get profileModel => _profileModel;

  Future<bool> readProfileData(String token) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.readProfile,
      accessToken: token,
    );
    if (response.isSuccess) {
      _errorMessage = null;
      if (response.responseData != null) {
        _profileModel = ProfileModel.fromJson(response.responseData["data"]);
      } else {
        _profileModel = null;
      }
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
