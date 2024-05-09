import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_prove/src/utils/producto.dart';

class ProductosModel extends ChangeNotifier {
  List<Producto> _productos = [];

  List<Producto> get productos => _productos;

  void addProducto(Producto producto) {
    _productos.add(producto);
    notifyListeners();
  }

  Future<void> cargarProductos(String jsonFile) async {
    String jsonString = await rootBundle.loadString(jsonFile);
    List<dynamic> json = jsonDecode(jsonString);
    _productos = json.map((productoJson) => Producto.fromJson(productoJson)).toList();
    notifyListeners();
  }
}