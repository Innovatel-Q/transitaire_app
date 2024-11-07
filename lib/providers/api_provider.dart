
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:trans_app/providers/local_storage_provider.dart';

class ApiProvider {

  final LocalStorageProvider localStorage = Get.find<LocalStorageProvider>();

  final Dio dio = Dio(
      BaseOptions(
          baseUrl: 'https://afrikababaa-571dedf1e98c.herokuapp.com/api',
          connectTimeout: const Duration(seconds: 6000),
          receiveTimeout: const Duration(seconds: 6000),
          contentType: 'application/json',
          responseType: ResponseType.json,
      )
  );

  ApiProvider() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        String? accessToken = localStorage.getToken();
        if (accessToken != null) {
          options.headers["Accept"] = "application/json";
          options.headers["Authorization"] = "Bearer $accessToken";
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401){
          if (!error.requestOptions.path.contains('/auth/login')) {
            final newAccessToken = await refreshToken();
            if (newAccessToken != null) {
              error.requestOptions.headers["Authorization"] = "Bearer $newAccessToken";
              return handler.resolve(await dio.fetch(error.requestOptions));
            }
          } 
        }
        return handler.next(error);
      },
    ));
  }

  Future<String?> refreshToken() async {
    final refreshToken = localStorage.getToken();
    print('Refresh token: $refreshToken');
    try {
      final response = await dio.post('/auth/refresh', data: {'refresh_token': refreshToken}, options: Options(headers: {'Accept': 'application/json', 'Authorization': 'Bearer $refreshToken'}));
      print('Refresh response: ${response.data}'); 
      if (response.statusCode == 200) {
        final newAccessToken = response.data['access_token'];
        await localStorage.saveToken(newAccessToken);
        return newAccessToken;
      }
    } catch (e) {
      print('Erreur détaillée lors du rafraîchissement du token : $e');
      rethrow;
    }
    return null;
  }
}
