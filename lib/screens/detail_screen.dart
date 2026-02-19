import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Imports de Componentes
import '../widgets/hero_detail_header.dart';
import '../widgets/detail_menu_bar.dart';
import '../widgets/detail_description.dart';
import '../widgets/primary_button.dart';
import '../widgets/amenities_list.dart';

// Imports de Datos
import '../models/hotel_model.dart';
import '../services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final int hotelId; // <--- ID REQUERIDO

  const DetailScreen({super.key, required this.hotelId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedIndex = 0;
  late Future<Hotel> _hotelDetailFuture; // Futuro para cargar datos
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Cargamos el detalle usando el ID que nos pasaron
    _hotelDetailFuture = _apiService.getHotelById(widget.hotelId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: FutureBuilder<Hotel>(
        future: _hotelDetailFuture,
        builder: (context, snapshot) {
          // 1. CARGANDO
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF6A2C70)));
          }
          // 2. ERROR
          else if (snapshot.hasError) {
            return Center(child: Text("Error al cargar detalle: ${snapshot.error}"));
          }
          // 3. SIN DATOS
          else if (!snapshot.hasData) {
            return const Center(child: Text("Información no disponible"));
          }

          // 4. DATOS LISTOS
          final hotel = snapshot.data!;

          return Stack(
            children: [
              // CAPA 1: HERO HEADER
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: size.height * 0.50,
                child: HeroDetailHeader(
                  imageUrl: hotel.imageUrl,
                  title: hotel.title,
                  location: hotel.location,
                  rating: hotel.reviews.toString(),
                  reviews: "350", // Dato simulado si no viene en API
                ),
              ),

              // CAPA 2: CONTENIDO BLANCO
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: size.height * 0.45, bottom: 120),
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
                          Center(
                            child: Container(
                              width: 40, height: 4, margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                            ),
                          ),

                          DetailMenuBar(
                            selectedIndex: _selectedIndex,
                            onItemSelected: (index) {
                              setState(() { _selectedIndex = index; });
                            },
                          ),

                          const SizedBox(height: 25),

                          // Contenido Dinámico según la pestaña
                          if (_selectedIndex == 0) ...[
                            DetailDescription(description: hotel.description),
                          ] else if (_selectedIndex == 1) ...[
                            AmenitiesList(amenities: hotel.amenities),
                          ] else if (_selectedIndex == 2) ...[
                            _buildLocationPlaceholder(hotel.location),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // CAPA 3: BOTONES SUPERIORES
              Positioned(
                top: 50, left: 20, right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CircleIconButton(
                      icon: Icons.arrow_back_ios_new,
                      onTap: () => Navigator.pop(context),
                    ),
                    _CircleIconButton(icon: Icons.favorite_border, onTap: () {}),
                  ],
                ),
              ),

              // CAPA 4: BOTÓN FLOTANTE
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))],
                  ),
                  child: PrimaryButton(
                    text: "Reservar Ahora",
                    onPressed: () {
                      print("Reservando ${hotel.title}");
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLocationPlaceholder(String location) {
    return Container(
      height: 200, width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.map_outlined, size: 40, color: Colors.grey[400]),
            const SizedBox(height: 10),
            Text("Ubicación: $location", style: GoogleFonts.poppins(color: Colors.grey[600])),
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
        width: 45, height: 45,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25), shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}