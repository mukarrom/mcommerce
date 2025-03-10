import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_commerce/features/cart/ui/screens/cart_screen.dart';
import 'package:m_commerce/features/category/ui/screens/category_screen.dart';
import 'package:m_commerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/main_layout_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/product_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/user_controller.dart';
import 'package:m_commerce/features/home/ui/controller/home_carousel_slider_controller.dart';
import 'package:m_commerce/features/home/ui/screens/home_screen.dart';
import 'package:m_commerce/features/wishlist/ui/controllers/wish_list_controller.dart';
import 'package:m_commerce/features/wishlist/ui/screens/wish_list_screen.dart';

class MainLayout extends StatefulWidget {
  static const String name = '/bottom-nav-layout';

  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const WishListScreen(),
  ];

  @override
  void initState() {
    Get.find<HomeCarouselSliderController>().getHomeBannerList();
    Get.find<CategoryListController>().getCategoryList();
    Get.find<ProductListController>().getProducts();
    _initLoadData();
    super.initState();
  }

  void _initLoadData() async {
    await Get.find<UserController>().checkUserLoggedIn();
    await Get.find<WishListController>().getWishedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLayoutController>(builder: (controller) {
      return Scaffold(
        body: _screens[controller.currentIndex],
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.category_outlined),
              label: 'Categories',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              label: 'Wish',
            ),
          ],
          selectedIndex: controller.currentIndex,
          onDestinationSelected: controller.changeIndex,
        ),
      );
    });
  }
}
