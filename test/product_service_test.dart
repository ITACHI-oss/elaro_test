import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app/features/product/data/model/product_model.dart';
import 'package:test_app/features/product/data/service/product_service.dart';

import 'mocks/mock_dio.mocks.dart';

void main() {
  late MockDio mockDio;
  late ProductService service;

  setUp(() {
    mockDio = MockDio();
    service = ProductService(mockDio);
  });

  test('ProductService returns product list from API', () async {
    final mockResponse = {
      'data': {
        'sub_categories': [
          {
            'id': 1,
            'name_uz': 'Monitor',
            'image': 'https://example.com/image.png',
            'category_id': 3,
            'color': '#000000',
          },
        ],
      },
    };

    when(
      mockDio.get(any, queryParameters: anyNamed('queryParameters')),
    ).thenAnswer(
      (_) async => Response(
        data: mockResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final result = await service.getFilteredProducts(categoryId: 3);

    expect(result, isA<List<ProductModel>>());
    expect(result.length, 1);
    expect(result.first.name, 'Monitor');
  });

  test('ProductService throws exception when response fails', () async {
    when(
      mockDio.get(any, queryParameters: anyNamed('queryParameters')),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Connection failed',
        type: DioExceptionType.unknown,
      ),
    );

    expectLater(
      () => service.getFilteredProducts(categoryId: 3),
      throwsA(isA<Exception>()),
    );
  });
}
