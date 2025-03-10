import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_commerce/app/assets_path.dart';
import 'package:m_commerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:m_commerce/features/common/data/models/category_model.dart';
import 'package:m_commerce/features/common/data/models/product_model.dart';
import 'package:m_commerce/features/common/ui/controllers/auth_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/main_layout_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/product_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/user_controller.dart';
import 'package:m_commerce/features/common/ui/widgets/app_bar_icon_button.dart';
import 'package:m_commerce/features/common/ui/widgets/category_items_icon_widget.dart';
import 'package:m_commerce/features/common/ui/widgets/product_item_widget.dart';
import 'package:m_commerce/features/home/ui/controller/home_carousel_slider_controller.dart';
import 'package:m_commerce/features/home/ui/widgets/home_carousel_slider.dart';
import 'package:m_commerce/features/home/ui/widgets/home_title_section.dart';
import 'package:m_commerce/features/home/ui/widgets/product_search_bar.dart';
import 'package:m_commerce/features/home/ui/widgets/shimmer_product_list_view.dart';
import 'package:m_commerce/features/products/ui/screens/products_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController _authController = Get.find<AuthController>();

  bool _isLoggedIn = false;

  @override
  void initState() {
    _isLoggedInFn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            // ---------- Product Search Bar
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  ProductSearchBar(),
                  SizedBox(height: 12),
                ],
              ),
            ),

            // ---------- Home Carousel Slider
            SliverToBoxAdapter(
              child: GetBuilder<HomeCarouselSliderController>(
                builder: (controller) {
                  if (controller.inProgress) {
                    return SizedBox(
                      width: double.infinity,
                      height: 150.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade50,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                    );
                  }
                  return HomeCarouselSlider(
                    sliders: controller.sliders ?? [],
                  );
                },
              ),
            ),

            // ---------- Home Category List
            SliverToBoxAdapter(
              child: Column(
                children: [
                  HomeTitleSection(
                    title: 'All Categories',
                    onPressed: () {
                      Get.find<MainLayoutController>().goToCategoryScreen();
                    },
                  ),
                  GetBuilder<CategoryListController>(
                    builder: (controller) {
                      if (controller.inProgress) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: const SizedBox(
                            width: double.infinity,
                            height: 80.0,
                            child: ColoredBox(color: Colors.red),
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              _getCategoryList(controller.categoryList ?? []),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // ---------- Product List
            SliverToBoxAdapter(
              child: HomeTitleSection(
                title: "Products",
                onPressed: () => _goToProductScreen(
                  context: context,
                  screenName: ProductsScreen.name,
                  isLoading: Get.find<ProductListController>().inProgress,
                  title: "All Products",
                  productList: Get.find<ProductListController>().productList,
                ),
              ),
            ),
            GetBuilder<ProductListController>(
              builder: (controller) {
                if (controller.inProgress) {
                  return const SliverToBoxAdapter(
                    child: ShimmerProductListView(),
                  );
                }
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => FittedBox(
                      child: ProductItemWidget(
                        productModel: controller.productList[index],
                      ),
                    ),
                    childCount: controller.productList.length,
                  ),
                );
              },
            ),

            // ---------- Spacer for Bottom Padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SizedBox(
        width: 120,
        child: SvgPicture.asset(AssetsPath.logoNav),
      ),
      actions: [
        const AppBarIconButton(icon: Icons.person_2_outlined),
        const AppBarIconButton(icon: Icons.call_outlined),
        const AppBarIconButton(icon: Icons.notifications_outlined),
        if (_isLoggedIn)
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              _authController.logout();
              _isLoggedInFn();
              setState(() {});
            },
          )
        else
          AppBarIconButton(
            icon: Icons.login_outlined,
            onTap: () {
              Navigator.pushNamed(context, SignInScreen.name);
              _isLoggedInFn();
              setState(() {});
            },
          ),
      ],
    );
  }

  List<Widget> _getCategoryList(List<CategoryModel> categoryList) {
    List<Widget> list = [];
    for (CategoryModel category in categoryList) {
      list.add(
        CategoryItemsIconWidget(
          title: category.title ?? "",
          icon: Icons.image_outlined,
          imageUrl: category.icon,
          categoryId: category.sId ?? "",
        ),
      );
    }
    return list;
  }

  void _goToProductScreen({
    required BuildContext context,
    required String screenName,
    required bool isLoading,
    required String title,
    required List<ProductModel> productList,
  }) {
    Navigator.pushNamed(
      context,
      screenName,
      arguments: {
        "isLoading": isLoading,
        "title": title,
        "productList": productList,
      },
    );
  }

  void _isLoggedInFn() async {
    _isLoggedIn = await _authController.isUserLoggedIn();
    await Get.find<UserController>().checkUserLoggedIn();
    setState(() {});
  }
}
