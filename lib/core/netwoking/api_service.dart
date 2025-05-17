import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'api_constants.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // @POST(ApiConstants.login)
  // Future<LoginResponse> login(
  //     @Body() LoginRequestBody loginRequestBody,
  //     );
  //
  // @POST(ApiConstants.signUp)
  // Future<void> signup(
  //     @Body() SignupRequestBody signupRequestBody,
  //     );

}
