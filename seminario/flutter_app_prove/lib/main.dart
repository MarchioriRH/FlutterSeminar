//import 'dart:ffi';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(  
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductosModel()..cargarProductos('productos.json'),
        ),  
        ChangeNotifierProvider(
          create: (context) => CarritoModel(),
        ),      
      ],
      child: const MiApp(),
    ),
  );
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrimeraPagina(),
    );
  }
}

class PrimeraPagina extends StatelessWidget {
  const PrimeraPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primera Página'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Ir a la segunda página'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SegundaPagina()),
            );
          },
        ),
      ),
    );
  }
}

class SegundaPagina extends StatelessWidget {
  const SegundaPagina({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Página'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
               onPressed: () {
                showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {                  
                    return Consumer<CarritoModel>(
                      builder: (context, carritoModel, child) {
                        return Column(
                          children: <Widget>[
                            const Expanded(
                              child: ListaCarrito(),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Total: \$${carritoModel.total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                                      
                
                },  
              );
            }
          ),
        ],
      ),
      body: Row(  // Cambiamos de Center a Row
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // Centramos las columnas
        children: <Widget>[
          const Expanded(  // Utilizamos Expanded para que cada columna ocupe la mitad de la pantalla
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                        child: Text("Datos de la empresa"),
                      )        
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Consumer<ProductosModel>(
                          builder: (context, productosModel, child) {
                            return ListaProductos(productos: productosModel.productos);
                          },
                        ),
                      )
                //     ],
                //   ),
                // ),
                // Expanded(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Expanded(child: Consumer<ProductosModel>(
                //           builder: (context, productosModel, child) {
                //             return ListaProductos(productos: productosModel.productos);
                //           },
                //         ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
  return Card(
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 120, // Ancho de la columna lateral
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
                  ),
                  leading: const Icon(
                    Icons.shopping_cart,  // Icono de la columna lateral
                    color: Color.fromARGB(255, 255, 255, 255),  // Color del icono
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
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Precio: \$$precio',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    TextButton(
                      child: const Text('COMPRAR'),
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
class ListaProductos extends StatelessWidget {
  const ListaProductos({super.key, required List<Producto> productos});

  //final int index;

  //const ListaProductos({super.key});

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




