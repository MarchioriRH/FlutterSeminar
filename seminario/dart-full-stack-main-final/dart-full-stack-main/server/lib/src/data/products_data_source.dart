import 'package:products_api/src/data/models/models.dart';

/// {@template products_data_source}
/// Interface that defines all the methods for Product data source
/// {@endtemplate}
abstract class ProductsDataSource {
  /// Returns the list of all the [Product]
  Future<List<Product>> getAllProducts();

  /// Returns a [Product] based on the provided [id]
  /// 
  /// Returns an empty [Product] if the id doesn't exist
  Future<Product> getProductById({required String id});
}
