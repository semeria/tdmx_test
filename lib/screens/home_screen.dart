import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Importamos nuestros nuevos componentes
import '../widgets/category_item.dart';
import '../widgets/travel_card.dart';
import '../widgets/promo_slider.dart';
import '../widgets/bottom_nav_item.dart';
import '../widgets/profile_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos los colores principales
    const Color purpleColor = Color(0xFF6A2C70);
    const Color greenColor = Color(0xFF00C800);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. EL CONTENIDO SCROLLABLE
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Esta función muestra la superposición desde abajo
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true, // Permite que sea más alto que la mitad de la pantalla
                              backgroundColor: Colors.transparent, // Hacemos transparente el fondo por defecto para usar nuestros bordes redondeados
                              builder: (context) => const ProfileView(), // Cargamos nuestro componente
                            );
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            // Asegúrate de usar la misma imagen aquí que en el perfil para consistencia
                            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- BARRA DE CATEGORÍAS ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: purpleColor.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CategoryItem(icon: Icons.local_offer_outlined, label: "Ofertas", color: purpleColor),
                          CategoryItem(icon: Icons.apartment, label: "Hoteles", color: Colors.black87),
                          CategoryItem(icon: Icons.signpost_outlined, label: "Tours", color: Colors.black87),
                          CategoryItem(icon: Icons.map_outlined, label: "Destinos", color: Colors.black87),
                          CategoryItem(icon: Icons.directions_bus_outlined, label: "Xolo Ruta", color: Colors.black87),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- SLIDER PROMO ---
                  const PromoSlider(),

                  const SizedBox(height: 25),

                  // --- SECCIÓN: TOURS ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Los mejores tours",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        TravelCard(
                          title: "Parque Xel-Ha",
                          subtitle: "Destino a Cancún",
                          imageUrl: "https://picsum.photos/300/200?random=1",
                          greenColor: greenColor,
                        ),
                        TravelCard(
                          title: "Chichén Itzá",
                          subtitle: "Destino a Yucatán",
                          imageUrl: "https://picsum.photos/300/200?random=2",
                          greenColor: greenColor,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- SECCIÓN: HOTELES ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Los mejores hoteles",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        TravelCard(
                          title: "Hotel Nickelodeon",
                          subtitle: "Riviera Maya",
                          imageUrl: "https://picsum.photos/300/200?random=3",
                          greenColor: greenColor,
                        ),
                        TravelCard(
                          title: "Xcaret Hotel",
                          subtitle: "Playa del Carmen",
                          imageUrl: "https://picsum.photos/300/200?random=4",
                          greenColor: greenColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. MENÚ FLOTANTE
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: purpleColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BottomNavItem(icon: Icons.local_offer, label: "Ofertas", isSelected: true),
                    BottomNavItem(icon: Icons.calendar_today, label: "Mi reservas", isSelected: false),
                    BottomNavItem(icon: Icons.stars, label: "XoloPuntos", isSelected: false),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}