import 'package:flutter/material.dart';
import 'package:m_commerce/app/app_colors.dart';

class SizePickerWidget extends StatefulWidget {
  const SizePickerWidget({super.key, required this.sizes, this.onChangeSize});

  final List<String> sizes;
  final void Function(String)? onChangeSize;

  @override
  State<SizePickerWidget> createState() => _SizePickerWidgetState();
}

class _SizePickerWidgetState extends State<SizePickerWidget> {
  late String _selectedSize;

  @override
  void initState() {
    if (widget.sizes.isNotEmpty) {
      _selectedSize = widget.sizes.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: widget.sizes.map((size) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedSize = size;
              widget.onChangeSize?.call(size);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: _selectedSize == size ? AppColors.themeColor : null,
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    _selectedSize == size ? AppColors.themeColor : Colors.black,
              ),
            ),
            width: 28,
            height: 28,
            child: Center(
              child: Text(
                size,
                style: TextStyle(
                  color: _selectedSize == size ? Colors.white : null,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
