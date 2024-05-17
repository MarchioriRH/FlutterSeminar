import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:products_api/src/data/products_data_source.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final method = context.request.method;

  if (method == HttpMethod.get) {
    return _onGetRequest(context, id);
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _onGetRequest(RequestContext context, String id) async {
  final productDataSource = context.read<ProductsDataSource>();

  final product = await productDataSource.getProductById(id: id);

  return Response.json(
    body: product,
  );
}
