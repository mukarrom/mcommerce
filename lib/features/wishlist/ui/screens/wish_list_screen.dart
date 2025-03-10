import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_commerce/features/common/ui/widgets/center_progress_indicator.dart';
import 'package:m_commerce/features/common/ui/widgets/product_item_widget.dart';
import 'package:m_commerce/features/wishlist/ui/controllers/wish_list_controller.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  static const String name = "/wish-list-screen";

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final WishListController _wishListController = Get.find<WishListController>();
  @override
  void initState() {
    _loadMoreProducts();
    super.initState();
  }

  void _loadMoreProducts() async {
    await _wishListController.getWishedProductList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wish List"),
        actions: [
          IconButton(
            onPressed: () async {
              _wishListController.reset();
              await Get.find<WishListController>().getWishedProductList();
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GetBuilder<WishListController>(
          builder: (controller) {
            if (controller.inProgress) {
              return const CenterProgressIndicator();
            }
            if (controller.productList.isEmpty) {
              return const Center(child: Text("No Product Found"));
            }
            return GridView.builder(
              itemCount: controller.productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (ctx, index) => FittedBox(
                  child: ProductItemWidget(
                productModel: controller.productList[index].product,
              )),
            );
          },
        ),
      ),
    );
  }
}
