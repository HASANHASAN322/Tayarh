import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:tayarh/utils/class/status_request.dart';
import '../../models/user_model.dart';
import '../set_my_user.dart';
import '../sevices/link.dart';
import 'check_internet.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(
      String linkUrl, Map data, Map<String, String> header) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkUrl),
          body: jsonEncode(data),
          headers: header,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkUrl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(
          Uri.parse(linkUrl),
          headers: getHeaderToken(),
        );

        Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          setMyUser(UserModel.fromJson(responseBody));
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }
}
