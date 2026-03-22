import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class ListCard extends StatelessWidget {
  final Widget child;

  const ListCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: AppTheme.grey300, spreadRadius: 1, blurRadius: 1),
        ],
      ),
      child: child,
    );
  }
}
