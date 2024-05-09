import 'package:flutter/material.dart';
import 'package:flutter_app_prove/src/models/carrito_model.dart';
import 'package:flutter_app_prove/src/utils/producto.dart';
import 'package:provider/provider.dart';

class ProductoCard extends StatelessWidget {
  final String nombreProducto;
  final String descripcion;
  final double precio;
  final String rutaImagen;

  const ProductoCard({super.key,
                required this.nombreProducto, 
                required this.descripcion, 
                required this.precio, 
                required this.rutaImagen
                });

  @override
  Widget build(BuildContext context) {   
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          child: AspectRatio(
            aspectRatio: 16 / 8,  // Ajusta esto a la relación de aspecto deseada
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth / 3, // Ancho de la columna lateral
                    color: Colors.blue,  // Color de la columna lateral
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            nombreProducto,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 56, 56, 57),  // Color del texto
                              fontSize: 15.0,  // Tamaño del texto
                              fontWeight: FontWeight.bold,  // Grosor del texto
                            ),
                          ),
                          subtitle: Text(
                            descripcion,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),  // Color del texto
                              fontSize: 11.0,  // Tamaño del texto
                              fontStyle: FontStyle.italic,  // Estilo del texto
                            ),
                          )
                        ),
                      ], // Texto de la columna lateral
                    ),            
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Image.asset(rutaImagen,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('No se pudo cargar la imagen');
                        }),  // Agregamos la imagen aquí
                        ListTile(
                          title: Text(nombreProducto),
                          subtitle: Text(descripcion),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Precio: \$$precio',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                            
                          ),
                        ),
                        ButtonBar(
                          buttonTextTheme: ButtonTextTheme.accent,
                          children: <Widget>[
                            MouseRegion(
                              cursor: SystemMouseCursors.click,                             
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.hovered)) {
                                        return Colors.lightGreen; // Color cuando el botón es hovered
                                      }
                                      return Colors.brown; // Color por defecto
                                    },
                                  ),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  elevation: MaterialStateProperty.all<double>(5.0),
                                ),
                                child: const Text(
                                  textScaler: TextScaler.linear(0.5),
                                  'Agregar al carrito',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                onPressed: () {
                                  Provider.of<CarritoModel>(context, listen: false).agregarProducto(
                                    Producto(
                                      nombreProducto: nombreProducto,
                                      descripcion: descripcion,
                                      precio: precio.toString(),
                                      rutaImagen: rutaImagen,
                                    ),
                                  ); /* código para comprar el producto */ 
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
