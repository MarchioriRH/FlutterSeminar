import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:products_api/src/data/products_data_source.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;

  if (method == HttpMethod.get) {
    return _onGetRequest(context);
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _onGetRequest(RequestContext context) async {
  final productDataSource = context.read<ProductsDataSource>();

  final products = await productDataSource.getAllProducts();

  return Response.json(
    body: {'products': products},
  );
}
