import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'model/network_reply.dart';
import 'napster_api.dart';

part 'dio_napster_service.g.dart';

const String baseUrl = "https://api.napster.com";

@RestApi(baseUrl: baseUrl)
abstract class NapsterService implements NapsterApi {

  factory NapsterService() {
    final _dio = Dio();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          request.queryParameters["apikey"] = "MmUyNDQ0OTgtMTQxZi00NTBjLThmZmItNTkwODEyOWI4ZDJj";
          handler.next(request);
        }
      )
    );
    _dio.interceptors.add(LogInterceptor());
    return _NapsterService(_dio);
  }

  @override
  @GET("/v2.2/tracks/top?limit=200")
  Future<HttpResponse<NetworkReply>> getTopTracks();
}