import 'package:get/get.dart';
import 'package:m_commerce/features/auth/ui/controllers/otpl_verification_controller.dart';
import 'package:m_commerce/features/auth/ui/controllers/read_profile_controller.dart';
import 'package:m_commerce/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:m_commerce/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/auth_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/main_layout_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/new_product_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/popular_product_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/regular_product_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/special_product_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/top_product_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/trending_product_list_controller.dart';
import 'package:m_commerce/features/home/ui/controller/home_banner_list_controller.dart';
import 'package:m_commerce/features/products/ui/controllers/product_details_controller.dart';
import 'package:m_commerce/features/products/ui/controllers/product_list_by_category_controller.dart';
import 'package:m_commerce/features/review/ui/controller/review_controller.dart';
import 'package:m_commerce/service/network/network_caller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainLayoutController());
    Get.put(NetworkCaller());
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(AuthController());
    Get.put(OtpVerificationController());
    Get.put(ReadProfileController());
    Get.put(HomeBannerListController());
    Get.put(CategoryListController());
    Get.put(NewProductListController());
    Get.put(PopularProductListController());
    Get.put(TrendingProductListController());
    Get.put(RegularProductListController());
    Get.put(TopProductListController());
    Get.put(SpecialProductListController());
    Get.put(ProductListByCategoryController());
    Get.put(ProductDetailsController());
    Get.put(ReviewController());
  }
}
