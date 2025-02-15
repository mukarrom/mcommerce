import 'package:flutter/material.dart';
import 'package:m_commerce/features/common/ui/widgets/center_progress_indicator.dart';
import 'package:m_commerce/features/common/ui/widgets/product_item_widget.dart';

class ProductsScreen extends StatefulWidget {
  static const String name = "/products-screen";

  const ProductsScreen({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.data["isLoading"]) {
      return const Scaffold(body: CenterProgressIndicator());
    }
    if (widget.data["isLoading"] == false &&
            widget.data["productList"] == null ||
        widget.data["productList"]?.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Products not found"),
          ),
          body: const Center(
            child: Text(
              "No Products Available",
              style: TextStyle(fontSize: 20),
            ),
          ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data["title"] ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: widget.data["productList"]?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (ctx, index) => FittedBox(
              child: ProductItemWidget(
            productModel: widget.data["productList"][index],
          )),
        ),
      ),
    );
  }
}
