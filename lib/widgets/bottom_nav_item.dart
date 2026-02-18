import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: isSelected
              ? const BoxDecoration(color: Colors.white, shape: BoxShape.circle)
              : null,
          child: Icon(
            icon,
            color: isSelected
                ? const Color(0xFF6A2C70)
                : Colors.white.withOpacity(0.6),
            size: 20,
          ),
        ),
        if (isSelected) ...[
          Text(
            label,
            style: GoogleFonts.poppins(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ] else ...[
          Text(
            label,
            style: GoogleFonts.poppins(
                fontSize: 10, color: Colors.white.withOpacity(0.6)),
          )
        ]
      ],
    );
  }
}