import 'package:flutter/material.dart';

class IngredientChip extends StatelessWidget {
  final String name;
  final num quantity;
  final String unit;
  final Function()?  onDelete;
  final Function()? onTap;
  const IngredientChip({super.key, this.name = '', this.quantity = 0, this.unit = '', this.onDelete, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent, 
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Chip(
        padding: const EdgeInsets.all(2.0),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$quantity $unit'),
            const VerticalDivider(indent: 4, endIndent: 4, thickness: 0.5),
            Text(name),
          ],
        ),
        shape: const StadiumBorder(
          side: BorderSide(
            width: 0.5,
            color: Colors.red,
          ),
        ),
        deleteIcon: Icon(Icons.close, size: 16, color: Colors.grey[600]),
        onDeleted: onDelete,
      )
    );
  }
}
