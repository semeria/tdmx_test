class Hotel {
  final int id;
  final String title;
  final String location;
  final String slug;
  final String imageUrl;
  final double price;
  final double reviews;
  // NUEVOS CAMPOS
  final String description;
  final List<String> amenities;

  Hotel({
    required this.id,
    required this.title,
    required this.location,
    required this.slug,
    required this.imageUrl,
    required this.price,
    required this.reviews,
    required this.description,
    required this.amenities,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    // 1. Imagen Principal
    String image = 'https://via.placeholder.com/300x200';
    if (json['images'] != null &&
        json['images']['principal'] != null &&
        (json['images']['principal'] as List).isNotEmpty) {
      image = json['images']['principal'][0]['url'] ?? image;
    }

    // 2. Amenidades (Si vienen en el JSON, las convertimos a lista de Strings)
    List<String> amenitiesList = [];
    if (json['amenities'] != null) {
      amenitiesList = List<String>.from(json['amenities'].map((x) => x['name'] ?? x.toString()));
    } else {
      // Default si no vienen
      amenitiesList = ["Transporte", "Wifi Gratis", "Desayuno", "Piscina"];
    }

    return Hotel(
      id: json['id'] ?? 0,
      title: json['name'] ?? 'Hotel sin nombre',
      location: json['destino'] ?? 'Destino desconocido',
      slug: json['slug'] ?? '',
      imageUrl: image,
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      reviews: double.tryParse(json['reviews']?.toString() ?? '4.5') ?? 4.5,
      // Mapeamos la descripción (ajusta la clave según tu API real: 'description', 'overview', etc.)
      description: json['description'] ?? json['overview'] ?? 'Descripción no disponible por el momento.',
      amenities: amenitiesList,
    );
  }
}