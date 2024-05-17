import 'package:products_api/src/data/models/product.dart';
import 'package:products_api/src/data/products_data_source.dart';

/// {@template in_memory_products_data_source}
/// An in-memory implementation of the [ProductsDataSource] interface.
/// {@endtemplate}
class InMemoryProductsDataSource extends ProductsDataSource {
  /// In memory [Product] list
  final List<Product> products = const [
    Product(id: '1', name: 'lapiz', price: 500.3),
    Product(id: '2', name: 'goma', price: 100.5),
    Product(id: '3', name: 'cartuchera', price: 2500.3),
    Product(id: '4', name: 'mochila', price: 23500.3),
    
  ];

  @override
  Future<List<Product>> getAllProducts() async {
    return products;
  }

  @override
  Future<Product> getProductById({required String id}) async {
    return products.firstWhere(
      (product) => product.id == id,
      orElse: () => const Product.empty(),
    );
  }
}
