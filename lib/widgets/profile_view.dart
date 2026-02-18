import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Colores extraídos de la imagen de referencia
    final Color backgroundColor = const Color(0xFFC4B0C7); // Morado claro de fondo
    final Color containerColor = const Color(0xFF8F6895); // Morado medio del contenedor
    final Color chipColor = const Color(0xFF86883B); // Verde oliva del chip
    final Color textColor = Colors.white;

    return Container(
      height: MediaQuery.of(context).size.height * 0.80, // Ocupa el 92% de la altura
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // --- HEADER: Botón X y Título ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Botón de cerrar "X" alineado a la izquierda
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () {
                       // Cierra el bottom sheet
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                // Título centrado
                Text(
                  "Mi perfil",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),

          // --- SECCIÓN DEL USUARIO (Avatar y datos) ---
          Center(
            child: Column(
              children: [
                // Avatar con icono de edición
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4), // Borde morado oscuro
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: containerColor.withOpacity(0.5),
                      ),
                      child: const CircleAvatar(
                        radius: 60,
                        // USA TU IMAGEN DE ASSETS AQUÍ: AssetImage('assets/tu_foto.png')
                        backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=11'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  "Barry Allen",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  "barryallen@tudestinomx.com",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: textColor.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 15),
                // Chip "Xolito Explorador"
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: chipColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Xolito Explorador",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // --- MENÚ DE OPCIONES ---
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _ProfileMenuItem(icon: Icons.person, text: "Mis datos"),
                    _ProfileMenuItem(icon: Icons.settings, text: "General"),
                    _ProfileMenuItem(icon: Icons.notifications_active, text: "Notificaciones"),
                    _ProfileMenuItem(icon: Icons.info, text: "Ayuda"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para los ítems del menú
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ProfileMenuItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {
        // Aquí iría la navegación a cada sección
      },
    );
  }
}