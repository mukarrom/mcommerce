import 'package:get/get.dart';
import 'package:m_commerce/app/urls.dart';
import 'package:m_commerce/features/common/data/models/product_list_model.dart';
import 'package:m_commerce/features/common/data/models/product_model.dart';
import 'package:m_commerce/service/network/network_caller.dart';
import 'package:m_commerce/service/network/network_response.dart';

class ProductListController extends GetxController {
  bool _inProgress = false;
  ProductListModel? _productListModel;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<ProductModel> get productList => _productListModel?.productList ?? [];
  String? get errorMessage => _errorMessage;

  Future<bool> getProductListByCategory(int categoryId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.productListByCategoryUrl(categoryId));
    if (response.isSuccess) {
      _productListModel = ProductListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
