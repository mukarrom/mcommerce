import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_commerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:m_commerce/features/common/ui/controllers/main_layout_controller.dart';
import 'package:m_commerce/features/common/ui/widgets/category_items_icon_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String name = "/category";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        leading: BackButton(
          onPressed: () {
            Get.find<MainLayoutController>().backToHome();
          },
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (_, __) {
          Get.find<MainLayoutController>().backToHome();
        },
        child: GetBuilder<CategoryListController>(builder: (controller) {
          return GridView.builder(
            itemCount: controller.categoryList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) => CategoryItemsIconWidget(
              title: controller.categoryList[index].categoryName ?? "",
              icon: Icons.image_outlined,
              imageUrl: controller.categoryList[index].categoryImg,
              categoryId: controller.categoryList[index].id!,
            ),
          );
        }),
      ),
    );
  }
}
