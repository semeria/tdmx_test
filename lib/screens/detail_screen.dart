import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Importamos tus componentes
import '../widgets/hero_detail_header.dart';
import '../widgets/detail_menu_bar.dart';
import '../widgets/detail_description.dart';
import '../widgets/primary_button.dart';
import '../widgets/amenities_list.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      // Usamos Stack para apilar elementos (Fondo -> Contenido -> Botones Flotantes)
      body: Stack(
        children: [
          // ---------------------------------------------------------
          // CAPA 1: HERO HEADER (Imagen de fondo)
          // ---------------------------------------------------------
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.50, // Ocupa la mitad de la pantalla
            child: const HeroDetailHeader(
              imageUrl: 'https://picsum.photos/id/10/800/800',
              title: "Bacalar",
              location: "Pueblo Mágico, Quintana Roo",
              rating: "4.5",
              reviews: "355",
            ),
          ),

          // ---------------------------------------------------------
          // CAPA 2: CONTENIDO SCROLLABLE (El panel blanco)
          // ---------------------------------------------------------
          Positioned.fill(
            // Positioned.fill asegura que el scroll ocupe toda la pantalla
            child: SingleChildScrollView(
              // IMPORTANTE: Este padding top baja el contenido para revelar la imagen
              // El padding bottom (100) deja espacio para que el botón flotante no tape el texto
              padding: EdgeInsets.only(
                top: size.height * 0.45, 
                bottom: 120
              ), 
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle (Barrita gris)
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      // Menú (Interactivo)
                      DetailMenuBar(
                        selectedIndex: _selectedIndex,
                        onItemSelected: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),

                      const SizedBox(height: 25),

                      // Contenido Cambiante
                      if (_selectedIndex == 0) ...[
                        const DetailDescription(
                          description:
                              "Ubicado en el estado de Quintana Roo, Bacalar es conocido como la \"Laguna de los Siete Colores\" debido a las impresionantes tonalidades de azul que se pueden observar en sus aguas.\n\nEs el lugar perfecto para relajarse, nadar en cenotes y disfrutar de la naturaleza en su estado más puro.",
                        ),
                      ] else if (_selectedIndex == 1) ...[
                        const AmenitiesList(
                          amenities: [
                            "Transporte redondo",
                            "Desayuno ligero",
                            "Comida buffet",
                            "Chaleco salvavidas",
                            "Guía bilingüe",
                            "Entrada al Cenote",
                          ],
                        ),
                      ] else if (_selectedIndex == 2) ...[
                        _buildLocationPlaceholder(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ---------------------------------------------------------
          // CAPA 3: BOTONES SUPERIORES (Atrás / Favorito)
          // ---------------------------------------------------------
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CircleIconButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.pop(context),
                ),
                _CircleIconButton(
                  icon: Icons.favorite_border,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // ---------------------------------------------------------
          // CAPA 4: BOTÓN FLOTANTE "RESERVAR AHORA" (Bottom Center)
          // ---------------------------------------------------------
          Positioned(
            bottom: 0, // Pegado al fondo
            left: 0,   // Pegado a la izquierda
            right: 0,  // Pegado a la derecha
            child: Container(
              // Un contenedor blanco con sombra para que el botón resalte sobre el texto
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30), // Padding extra abajo para iPhone X+
              decoration: BoxDecoration(
                color: Colors.white, 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Sombra suave hacia arriba
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: PrimaryButton(
                text: "Reservar Ahora",
                onPressed: () {
                  print("Click en reservar");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.map_outlined, size: 40, color: Colors.grey[400]),
            const SizedBox(height: 10),
            Text("Mapa de Ubicación", style: GoogleFonts.poppins(color: Colors.grey[500])),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}