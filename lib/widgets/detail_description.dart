import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailDescription extends StatelessWidget {
  final String title;
  final String description;

  const DetailDescription({
    super.key,
    this.title = "Descripción", // Título por defecto
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.grey[600],
            height: 1.6, // Altura de línea para mejor lectura
          ),
        ),
      ],
    );
  }
}