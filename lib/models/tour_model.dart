class Tour {
  final String id;
  final String title;
  final String location; // Para el subtítulo
  final String imageUrl;
  final double rating;
  final double price;

  Tour({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.price,
  });

  // Factory para crear un Tour desde un mapa (JSON)
  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'].toString(),
      title: json['title'] ?? 'Tour sin nombre',
      location: json['location'] ?? 'Ubicación desconocida',
      // Asegúrate que tu API envíe la URL completa, si no, concátenca el dominio base
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/300', 
      rating: (json['rating'] ?? 0.0).toDouble(),
      price: (json['price'] ?? 0.0).toDouble(),
    );
  }
}