import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TravelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color greenColor;
  final VoidCallback? onBookPressed;

  const TravelCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.greenColor = const Color(0xFF00C800),
    this.onBookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(imageUrl, height: 140, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hotel", style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
                Row(children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 14))),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF6A2C70)),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: onBookPressed,
                    icon: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 18),
                    label: Text(
                      "MAS INFORMACIÓN",
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}