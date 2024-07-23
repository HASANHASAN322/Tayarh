

import 'package:get/get_connect/http/src/response/response.dart';

class ApiResponse<T> {
  final Response<T>? response;
  final dynamic error;

  ApiResponse(this.response, this.error);

  ApiResponse.withError(dynamic errorValue)
      : response = null,
        error = errorValue;

  ApiResponse.withSuccess(Response<T> responseValue)
      : response = responseValue,
        error = null;

}

