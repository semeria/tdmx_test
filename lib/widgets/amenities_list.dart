import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmenitiesList extends StatelessWidget {
  final String title;
  final List<String> amenities;

  const AmenitiesList({
    super.key,
    this.title = "Qué incluye", // Título por defecto
    required this.amenities,
  });

  @override
  Widget build(BuildContext context) {
    // Color verde para los checks (mismo que el botón)
    const Color checkColor = Color(0xFF00C800); 

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        
        // Generamos la lista de items
        ...amenities.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 10), // Espacio entre items
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icono de Check
              const Icon(
                Icons.check_circle_outline, 
                color: checkColor, 
                size: 20
              ),
              const SizedBox(width: 10),
              
              // Texto de la amenidad
              Expanded(
                child: Text(
                  item,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.2, // Altura de línea para que se alinee bien con el icono
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}