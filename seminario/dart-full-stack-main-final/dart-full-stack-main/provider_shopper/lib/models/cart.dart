// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:products_api/api.dart';
import 'package:products_repository/products_repository.dart';



class CartModel extends ChangeNotifier {
  /// The private field backing [catalog].
  //late CatalogModel _catalog;
  late ProductsRepository _catalog;

  
  

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<Product> _items = [];
  final List<Product> _favorites = [];

  /// The current catalog. Used to construct items from numeric ids.
  //CatalogModel get catalog => _catalog;

  ProductsRepository get catalog => _catalog;



  set catalog(ProductsRepository newCatalog) {
    _catalog = newCatalog;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

   /// List of Products in the cart.
  List<Product> get items => _items;

  /// List of Products in the favorites.
  List<Product> get favorites => _favorites;

  /// The current total price of all items.
  double get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  /// Adds [Product] to cart. This is the only way to modify the cart from outside.
  void add(Product item) {
    if (!_items.contains(item)) {
      _items.add(item);
      // This line tells [Model] that it should rebuild the widgets that
      // depend on it.
      notifyListeners();
    } 
  }

  void remove(Product item) {
    _items.remove(item);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }

  // Adds [Product] to favorites.
  bool addFavorite(Product item) {
    if (_favorites.contains(item)) {
      return false;
    }
    _favorites.add(item);
    notifyListeners();
    return true;
  }

  void removeFavorite(Product item) {
    _favorites.remove(item);
    notifyListeners();
  }

  double get totalFavoritesPrice =>
    _favorites.fold(0, (total, current) => total + current.price);
}
