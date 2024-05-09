class Producto {
  final String nombreProducto;
  final String descripcion;
  final String precio;
  final String rutaImagen;

  Producto({required this.nombreProducto, required this.descripcion, required this.precio, required this.rutaImagen});

  // Crea un objeto Producto a partir de un mapa
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      nombreProducto: json['nombreProducto'],
      descripcion: json['descripcion'],
      precio: json['precio'],
      rutaImagen: json['rutaImagen'],
    );
  }
}