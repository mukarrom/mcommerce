import 'package:flutter/material.dart';
import 'package:m_commerce/app/app_colors.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({super.key, required this.colors});

  final List<Color> colors;
  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late Color _selectedColor;

  @override
  void initState() {
    if (widget.colors.isNotEmpty) {
      _selectedColor = widget.colors.first;
    } else {
      _selectedColor = AppColors.themeColor;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: widget.colors.map((color) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedColor = color;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: color == Colors.white
                    ? AppColors.themeColor
                    : Colors.transparent,
              ),
            ),
            width: 28,
            height: 28,
            child: Icon(
              Icons.check,
              color: _selectedColor != color
                  ? Colors.transparent
                  : color == Colors.white
                      ? AppColors.themeColor
                      : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }
}
