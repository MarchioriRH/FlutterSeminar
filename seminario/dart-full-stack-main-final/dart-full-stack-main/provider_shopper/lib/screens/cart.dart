// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.displayLarge),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              showFavoritesModal(context);                           
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }

  Future<Widget?> showFavoritesModal(BuildContext context) {
    final GlobalKey<ScaffoldState> modelScaffoldKey = GlobalKey<ScaffoldState>();
    return showModalBottomSheet<Widget>(
    context: context,
    builder: (_) => Scaffold(
        backgroundColor: Color.fromARGB(255, 200, 244, 53),
        key: modelScaffoldKey,
        body: 
         Consumer<CartModel>(
          builder: (context, cart, child) {
            return _buildFavoriteList(context, cart);
          },
        ),
      ),
    );    
  }

  Container _buildFavoriteList(BuildContext context, CartModel cart) {
    return Container( 
      padding: EdgeInsets.all(16.0), 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Favorites',
                style: Theme.of(context).textTheme.displayLarge,
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 25, color: Color.fromARGB(255, 38, 38, 38), semanticLabel: 'LEAVE FAVORITES',),
                  onPressed: () {
                    Navigator.pop(context);
                  }
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.favorite),
                  title: Text(cart.favorites[index].name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline, semanticLabel: 'REMOVE',),
                        onPressed: () {
                          cart.removeFavorite(cart.favorites[index]);
                          if (cart.favorites.isEmpty) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.shop, semanticLabel: 'SHOP',),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Shop not implemented yet.'), duration: Duration(seconds: 1)));
                        },
                      ),
                    ],  
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(height: 4, color: Color.fromARGB(255, 240, 24, 24)),
              Text('Total: \$${cart.totalFavoritesPrice.toStringAsFixed(2)}', style: Theme.of(context).textTheme.displayLarge),
            ],
          ),
        ],
      ),
    );
  }
}


class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;
    // This gets the current state of CartModel and also tells Flutter
    // to rebuild this widget when CartModel notifies listeners (in other words,
    // when it changes).
    var cart = context.watch<CartModel>();

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.done),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                cart.remove(cart.items[index]);
              },
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border, semanticLabel: 'ADD TO FAVORITES',),
              onPressed: () {
                if (cart.addFavorite(cart.items[index])) {
                  cart.remove(cart.items[index]);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Already in favorites.')));
                }
              },
            ),
          ],
        ),
        title: Text(
          cart.items[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
      Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 48);
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [            
            Consumer<CartModel>(
              builder: (context, cart, child) =>
                Text('\$${cart.totalPrice.toStringAsFixed(2)}', style: hugeStyle)),
            const SizedBox(width: 24),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Buying not supported yet.'), duration: Duration(seconds: 1))
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
