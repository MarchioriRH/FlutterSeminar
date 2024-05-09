import 'package:flutter/material.dart';
import 'package:flutter_app_prove/src/models/carrito_model.dart';
import 'package:flutter_app_prove/src/models/producto_model.dart';
import 'package:flutter_app_prove/src/utils/producto.dart';
import 'package:flutter_app_prove/src/utils/producto_card.dart';
import 'package:provider/provider.dart';

class ListaProductos extends StatelessWidget {
  const ListaProductos({super.key, required List<Producto> productos});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductosModel>(
      builder: (context, productosModel, child) {
        return ListView.builder(
          itemCount: productosModel.productos.length,
          itemBuilder: (context, index) {
            return ProductoCard(
              nombreProducto: productosModel.productos[index].nombreProducto,
              descripcion: productosModel.productos[index].descripcion,
              precio: double.parse(productosModel.productos[index].precio),
              rutaImagen: productosModel.productos[index].rutaImagen,
            );
          },
        );
      },
    );
  }
 }
class ListaCarrito extends StatelessWidget {
  const ListaCarrito({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarritoModel>(
      builder: (context, carritoModel, child) {
        return ListView.builder(
          itemCount: carritoModel.productos.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: Text('\$${carritoModel.productos[index].precio}'),
              title: Text(carritoModel.productos[index].nombreProducto), 
              subtitle: Text(carritoModel.productos[index].descripcion),
              leading: Image.asset(carritoModel.productos[index].rutaImagen),
            );
          },
        );
      },
    );
  }
}