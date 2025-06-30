import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'features/product/data/service/product_service.dart';
import 'features/product/data/repository/product_repository.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/screens/products_screen.dart';

void main() {
  final dio = Dio();
  final service = ProductService(dio);
  final repository = ProductRepository(service);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => ProductsBloc(repository)..add(
                LoadProducts(
                  categoryId: 3,
                  priceMin: 10000000,
                  priceMax: 20000000,
                  color: '#050505',
                ),
              ),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
