//import 'dart:ffi';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_prove/src/utils/listas.dart';
import 'package:provider/provider.dart';
//import 'dart:convert';
//import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:flutter_app_prove/src/models/carrito_model.dart';
import 'package:flutter_app_prove/src/models/producto_model.dart';
//import 'package:flutter_app_prove/src/utils/producto.dart';

void main() {
  runApp(  
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductosModel()..cargarProductos('files/productos.json'),
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
      title: 'The Cofee House',
      theme: ThemeData(
        primarySwatch: Colors.brown,
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
        title: const Text('The Coffee House'),
        backgroundColor: const Color.fromARGB(255, 188, 158, 148),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder (
                  builder: (BuildContext context, BoxConstraints constraints) {
                        return Image.asset(
                          'images/home_page.jpeg',
                          width: constraints.maxWidth < 500 ? constraints.maxWidth : 500,
                          //height: constraints.maxHeight < 500 ? constraints.maxHeight : 500,
                          fit: BoxFit.scaleDown,
                        );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.brown, // foreground
                  side: const BorderSide(color: Colors.black, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),                
                ),
                child: const Text('See our shop'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SegundaPagina()),
                  );
                },
              ),
            ],
          ),
          ),
        ],
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
        title: const Text('The Coffee House'),
        backgroundColor: const Color.fromARGB(255, 188, 158, 148),    
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
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (constraints.maxWidth > 600) ...[
                    const Expanded(
                      flex:1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ],
                  Expanded(
                    flex:2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Consumer<ProductosModel>(
                            builder: (context, productosModel, child) {
                              return ListaProductos(productos: productosModel.productos);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (constraints.maxWidth > 600) ...[
                    const Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}