import 'package:flutter/material.dart';
import 'package:m_commerce/features/common/ui/widgets/product_item_widget.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductListView extends StatelessWidget {
  const ShimmerProductListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: const Row(
        children: [
          ProductItemWidget(),
          ProductItemWidget(),
          ProductItemWidget(),
          ProductItemWidget(),
        ],
      ),
    );
  }
}
