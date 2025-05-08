import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget _buildIconButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.share,
            color: Colors.black,
          ), // icon param not used here, fix:
        ),
      ),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(color: Colors.white)),
    ],
  );
}