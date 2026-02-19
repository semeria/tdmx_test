import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroDetailHeader extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String rating;
  final String reviews;

  const HeroDetailHeader({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    // Usamos LayoutBuilder para saber el tamaño disponible si es necesario, 
    // pero aquí confiaremos en que el padre le da el tamaño (Positioned).
    
    final Color yellowColor = const Color(0xFFFEBD2F);

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. La Imagen de Fondo
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        
        // 2. El Degradado Negro (Sombra inferior)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.5, 1.0],
            ),
          ),
        ),

        // 3. Texto Centrado
        // Usamos Align para posicionarlo en la parte inferior del header
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60, left: 20, right: 20), // Ajuste inferior para que no choque con el panel blanco
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ocupa solo lo necesario
              crossAxisAlignment: CrossAxisAlignment.center, // <--- CENTRADO HORIZONTAL
              children: [
                // Título
                Text(
                  title,
                  textAlign: TextAlign.center, // Asegura que si es largo se centre
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        blurRadius: 10,
                        color: Colors.black45,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                
                // Ubicación (Centrada)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // <--- CENTRADO
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 18),
                    const SizedBox(width: 5),
                    Text(
                      location,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Estrellas y Reviews (Centrada)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // <--- CENTRADO
                  children: [
                    Icon(Icons.star, color: yellowColor, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      rating,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}