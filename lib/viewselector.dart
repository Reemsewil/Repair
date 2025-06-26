import 'package:flutter/material.dart';

class ViewSelector extends StatelessWidget {
  final String selectedView;
  final Function(String) onSelected;

  const ViewSelector({
    super.key,
    required this.selectedView,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      initialValue: selectedView,
      onSelected: onSelected,
      itemBuilder:
          (BuildContext context) => [
            const PopupMenuItem<String>(value: 'week', child: Text('أسبوع')),
            const PopupMenuItem<String>(value: 'month', child: Text('شهر')),
            const PopupMenuItem<String>(value: 'year', child: Text('سنة')),
          ],
    );
  }
}
