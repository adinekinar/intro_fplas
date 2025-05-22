import 'package:flutter/material.dart';

Widget courseCard({
  required IconData icon,
  required String title,
  required String status,
  required String subStatus,
  Color? iconColor,
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor?.withOpacity(0.15) ?? Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor ?? Colors.grey, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(status,
                    style: TextStyle(color: Colors.black.withOpacity(0.7))),
                Text(subStatus,
                    style: TextStyle(color: Colors.black.withOpacity(0.5))),
              ],
            ),
          )
        ],
      ),
    ),
  );
}