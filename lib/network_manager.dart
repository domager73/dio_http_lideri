import 'package:dio/dio.dart';
import 'package:http_liberi/models/profile.dart';

class NetworkManager {
  static const _url = "https://api.github.com/users/domager73";
  Dio? _dio;

  Dio get _dioGetter {
    _dio ??= Dio();
    _dio!.interceptors
      ..add(InterceptorsWrapper(onRequest: (option, handler) {
        option.headers['auth'] = '123';
        handler.next(option);
      }, onResponse: (e, handler) {
        print(e);
        handler.next(e);
      },),)
      ..add(RetryInt(_dio!));
    return _dio!;
  }

  NetworkManager();

  Future<GithubProfile> getData() async {
    final response = await _dioGetter.get<Map<String, dynamic>>(_url);

    if (response.statusCode == 200) {
      final data = response.data;
      if (data != null) {
        return GithubProfile.fromJson(data);
      }
    }

    throw ArgumentError("Unknow status code");
  }
}

class RetryInt extends Interceptor {
  final Dio dio;

  const RetryInt(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionTimeout) {
      final option = err.requestOptions;
      dio.request(
        option.path,
      );
    }
  }
}
//default dio request
// class NetworkManager {
//   static const _url = "https://api.github.com/users/domager73";
//   final dio = Dio();
//
//   NetworkManager();
//
//   Future<GithubProfile> getData() async {
//     final response = await dio.get<Map<String, dynamic>>(_url);
//
//     if(response.statusCode == 200){
//       final data = response.data;
//       if(data != null){
//         return GithubProfile.fromJson(data);
//       }
//     }
//
//     throw ArgumentError("Unknow status code");
//   }
// }

// http request
// final cl = RetryClient(_MyClient());
//
// NetworkManager();
//
// Future<GithubProfile> getData() async {
//   final uri = Uri.parse(_url);
//   final response = await cl.get(uri);
//
//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     final body = response.body;
//     final json = jsonDecode(body) as Map<String, dynamic>;
//     final profile = GithubProfile.fromJson(json);
//     return profile;
//   }
//
//   throw ArgumentError("Unknow status code");
// }
//--------------------
// class _MyClient extends BaseClient {
//   final client = Client();
//
//   @override
//   Future<StreamedResponse> send(BaseRequest request) {
//     request.headers['auth'] = '123';
//     return client.send(request);
//   }
// }
