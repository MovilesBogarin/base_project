import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final List<Widget>? stepsContainers;
  final bool isEditing;
  final Function()? onAddStep;
  const CustomContainer({super.key, this.stepsContainers, this.isEditing = false, this.onAddStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          ...?stepsContainers,
          if (stepsContainers!.isEmpty && !isEditing) const Text('No hay pasos'),
          if (isEditing) InkWell(
            onTap: onAddStep,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54)
              ),
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add, color: Colors.grey[600], size: 16)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}