import 'package:dio/dio.dart';
import 'package:quitanda_udemy/src/constants/endpoints.dart';
import 'package:quitanda_udemy/src/models/category_model.dart';
import 'package:quitanda_udemy/src/models/item_model.dart';
import 'package:quitanda_udemy/src/pages/home/result/home_result.dart';
import 'package:quitanda_udemy/src/services/http_manager.dart';

class HomeRespository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar as categorias');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(Map<String, dynamic> body,
      {CancelToken? cancelToken}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllProducts,
      method: HttpMethods.post,
      body: body,
      cancelToken: cancelToken,
    );

    if (result['result'] != null) {
      List<ItemModel> data = List<Map<String, dynamic>>.from(result['result'])
          .map(ItemModel.fromJson)
          .toList();

      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar os itens');
    }
  }
}
