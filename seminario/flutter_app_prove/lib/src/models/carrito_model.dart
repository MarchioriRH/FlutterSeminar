import 'package:flutter/material.dart';
import 'package:flutter_app_prove/src/utils/producto.dart';

class CarritoModel extends ChangeNotifier {
  final List<Producto> _productosEnCarrito = [];

  List<Producto> get productos => _productosEnCarrito;

  double get total {
    return productos.fold(0, (total, current) => total + double.parse(current.precio));
  }

  void agregarProducto(Producto producto) {
    _productosEnCarrito.add(producto);
    notifyListeners();
  }

  void eliminarProducto(Producto producto) {
    _productosEnCarrito.remove(producto);
    notifyListeners();
  }
}