import 'package:dart_frog/dart_frog.dart';
import 'package:products_api/src/data/in_memory_products_data_source.dart';
import 'package:products_api/src/data/products_data_source.dart';



final _productsDataSource = InMemoryProductsDataSource();

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<ProductsDataSource>((_) => _productsDataSource));
}
