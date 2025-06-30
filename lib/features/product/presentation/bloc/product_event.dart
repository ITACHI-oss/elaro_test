part of 'product_bloc.dart';

abstract class ProductsEvent {}

class LoadProducts extends ProductsEvent {
  final int categoryId;
  final int? priceMin;
  final int? priceMax;

  LoadProducts({required this.categoryId, this.priceMin, this.priceMax});
}
