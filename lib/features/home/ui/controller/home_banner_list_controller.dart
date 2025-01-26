import 'package:get/get.dart';
import 'package:m_commerce/app/urls.dart';
import 'package:m_commerce/features/home/data/models/banner_list_model.dart';
import 'package:m_commerce/features/home/data/models/banner_model.dart';
import 'package:m_commerce/service/network/network_caller.dart';
import 'package:m_commerce/service/network/network_response.dart';

class HomeBannerListController extends GetxController {
  bool _inProgress = false;
  BannerListModel? _bannerListModel;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<BannerModel> get bannerList => _bannerListModel?.bannerList ?? [];
  String? get errorMessage => _errorMessage;

  Future<bool> getHomeBannerList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.bannerListUrl,
    );
    if (response.isSuccess) {
      _errorMessage = null;
      _bannerListModel = BannerListModel.fromJson(response.responseData!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
