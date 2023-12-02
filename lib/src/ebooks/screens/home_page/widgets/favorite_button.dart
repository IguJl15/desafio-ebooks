import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.onTap,
    required this.active,
  });

  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    const size = Size(30, 60);
    const bevelRadius = 15.0;

    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: size,
        maximumSize: size,
        backgroundColor: active ? Colors.red : Colors.grey[50],
        foregroundColor: active ? Colors.white : Colors.grey[400],
        surfaceTintColor: Colors.red[100],
        elevation: active ? 2 : 4,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bevelRadius),
            bottomRight: Radius.circular(bevelRadius),
          ),
        ),
      ),
      child: active ? Icon(Icons.bookmark_added) : Icon(Icons.bookmark_border),
    );
  }
}
