import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:products_api/api.dart';
import 'package:products_api/src/data/models/models.dart';


part 'product.g.dart'; //se genera con dart run build_runner build -d 

/// {@template product}
/// A Product object
/// {@endtemplate}
@JsonSerializable()
class Product extends Equatable {
  /// {@macro product}
  const Product({
    required this.id,
    required this.name,
    required this.price,
  });

  /// An instance of an empty [Product]
  const Product.empty() : this(id: '', name: '', price: 0);

  /// Deserializes the given `Map<String, dynamic>` into a [Product].
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  /// Product identifier
  final String id;

  /// Product name
  final String name;

  /// Product price
  final double price;

  /// Serializes the given [Product] into a `Map<String, dynamic>`
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  /// Returns a copy of a [Product] using the given values
  Product copyWith({
    String? id,
    String? name,
    double? price,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
      );

  @override
  List<Object?> get props => [id, name, price];
}
