import 'package:get/get.dart';
import 'package:m_commerce/app/urls.dart';
import 'package:m_commerce/features/products/data/model/product_detatils_model.dart';
import 'package:m_commerce/service/network/network_caller.dart';
import 'package:m_commerce/service/network/network_response.dart';

class ProductDetailsController extends GetxController {
  bool _isLoading = true;
  ProductDetailsListModel? _productDetailsListModel;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<ProductDetailsModel>? get productDetailsList =>
      _productDetailsListModel?.productDetailsList ?? [];
  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.productDetailsUrl(productId),
    );
    if (response.isSuccess) {
      _productDetailsListModel =
          ProductDetailsListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
