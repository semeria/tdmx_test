import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailMenuBar extends StatelessWidget {
  // Recibimos el índice actual y la función para cambiarlo
  final int selectedIndex;
  final Function(int) onItemSelected;

  const DetailMenuBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Lista de opciones del menú
    final List<String> menuItems = [
      "Descripción",
      "Amenidades",
      "Ubicación",
    ];

    // Colores del tema
    const Color activeColor = Color(0xFF6A2C70); 
    const Color inactiveColor = Color(0xFFF5F5F5); 
    const Color activeTextColor = Colors.white;
    const Color inactiveTextColor = Color(0xFF888888);

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menuItems.length,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        itemBuilder: (context, index) {
          // Comparamos con el índice que recibimos del padre
          final bool isSelected = index == selectedIndex;

          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Avisamos al padre que se tocó este índice
                  onItemSelected(index);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? activeColor : inactiveColor,
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected
                        ? null
                        : Border.all(color: Colors.black.withOpacity(0.05)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    menuItems[index],
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? activeTextColor : inactiveTextColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}