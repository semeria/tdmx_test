import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/category_item.dart';
import '../widgets/travel_card.dart';
import '../widgets/promo_slider.dart';
import '../widgets/bottom_nav_item.dart';
import '../widgets/profile_view.dart';

// Imports de API
import '../models/hotel_model.dart';      
import '../services/api_service.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Hotel>> _hotelsFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _hotelsFuture = _apiService.getHotels();
  }

  @override
  Widget build(BuildContext context) {
    const Color purpleColor = Color(0xFF6A2C70);
    const Color greenColor = Color(0xFF00C800);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
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
                          width: 40, height: 40, 
                          child: Image.asset('assets/logo.png', fit: BoxFit.contain)
                        ),
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const ProfileView(),
                          ),
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- CATEGORÍAS ---
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
                  const PromoSlider(),
                  const SizedBox(height: 25),

                  // ---------------------------------------------------
                  // SECCIÓN: HOTELES DESDE API
                  // ---------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Hoteles Destacados",
                      style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 320,
                    child: FutureBuilder<List<Hotel>>(
                      future: _hotelsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: purpleColor));
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error: ${snapshot.error}"));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text("No se encontraron hoteles"));
                        }

                        final hotels = snapshot.data!;
                        final displayHotels = hotels.take(4).toList();

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 20),
                          itemCount: displayHotels.length,
                          itemBuilder: (context, index) {
                            final hotel = hotels[index];
                            return TravelCard(
                              title: hotel.title,
                              subtitle: hotel.location,
                              imageUrl: hotel.imageUrl,
                              greenColor: greenColor,
                              onBookPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(hotelId: hotel.id), // Pasamos el ID
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                ],
              ),
            ),

            // --- MENÚ FLOTANTE ---
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
                    BottomNavItem(icon: Icons.calendar_today, label: "Mis reservas", isSelected: false),
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