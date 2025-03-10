import 'package:get/get.dart';
import 'package:m_commerce/app/urls.dart';
import 'package:m_commerce/features/common/data/models/paginate_model.dart';
import 'package:m_commerce/features/home/data/models/slider_model.dart';
import 'package:m_commerce/service/network/network_caller.dart';
import 'package:m_commerce/service/network/network_response.dart';

class HomeCarouselSliderController extends GetxController {
  bool _inProgress = false;
  PaginateModel<SliderModel>? _paginateModel;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<SliderModel>? get sliders => _paginateModel?.results ?? [];
  String? get errorMessage => _errorMessage;

  Future<bool> getHomeBannerList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.slides,
    );
    if (response.isSuccess) {
      _errorMessage = null;
      _paginateModel = PaginateModel.fromJson(
        response.responseData["data"],
        SliderModel.fromJson,
      );
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
