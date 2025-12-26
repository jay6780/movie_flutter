import 'package:dio/dio.dart';
import 'package:free_movie/app/constants/appconstant.dart';
import 'package:free_movie/app/service/auth_interceptor.dart';
import 'package:free_movie/app/service/interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final _baseUrl = "https://api.themoviedb.org/3/";
  final _receiveTimeout = const Duration(seconds: 60);
  final _connectTimeout = const Duration(seconds: 60);
  final _sendTimeout = const Duration(seconds: 60);

  late Dio _dio;
  bool isDev = Appconstant.isDev;
  ApiService._internal();

  static final ApiService _apiService = ApiService._internal();

  factory ApiService() => _apiService;

  Dio provideDio() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: _baseUrl,
      receiveTimeout: _receiveTimeout,
      connectTimeout: _connectTimeout,
      sendTimeout: _sendTimeout,
    );

    PrettyDioLogger prettyDioLogger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );
    Interceptor customInterceptor = CustomInterceptor();

    _dio = Dio(baseOptions);

    // Add the Interceptors here
    isDev
        ? _dio.interceptors.addAll({
            prettyDioLogger,
            customInterceptor,
            AuthInterceptor(dio: _dio),
          })
        : _dio.interceptors.addAll({
            customInterceptor,
            AuthInterceptor(dio: _dio),
          });

    return _dio;
  }
}
