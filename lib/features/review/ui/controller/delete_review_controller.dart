import 'package:get/get.dart';
import 'package:m_commerce/app/urls.dart';
import 'package:m_commerce/service/network/network_caller.dart';
import 'package:m_commerce/service/network/network_response.dart';

class DeleteReviewController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> deleteReviewById(String reviewId) async {
    bool isSuccess = false;
    _isLoading = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().deleteRequest(
      Urls.deleteReviewById(reviewId),
    );
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
