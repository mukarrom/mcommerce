import 'package:flutter/material.dart';
import 'package:m_commerce/app/app_colors.dart';

class CountIncrementDecrementWidget extends StatefulWidget {
  const CountIncrementDecrementWidget(
      {super.key, this.onChangeCount, this.count});

  final void Function(int)? onChangeCount;
  final int? count;

  @override
  State<CountIncrementDecrementWidget> createState() =>
      _CountIncrementDecrementWidgetState();
}

class _CountIncrementDecrementWidgetState
    extends State<CountIncrementDecrementWidget> {
  int _quantity = 1;

  @override
  void initState() {
    if (widget.count != null) {
      _quantity = widget.count!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Row(
      children: [
        _incrementDecrementButton(
          () {
            if (_quantity > 1) {
              setState(() {
                _quantity--;
              });
            }
            widget.onChangeCount?.call(_quantity);
          },
          Icons.remove,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            _quantity.toString().padLeft(2, "0"),
            style: textStyle.titleMedium,
          ),
        ),
        _incrementDecrementButton(
          () {
            if (_quantity < 20) {
              setState(() {
                _quantity++;
              });
            }
            widget.onChangeCount?.call(_quantity);
          },
          Icons.add,
        ),
      ],
    );
  }

  Widget _incrementDecrementButton(VoidCallback? onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.themeColor,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
