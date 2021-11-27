import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart';

import 'leetcodeResponse.dart';

class Compiler {
  static String compilerApi = "https://ide.geeksforgeeks.org/main.php";
  static String fetchResultsApi =
      "https://ide.geeksforgeeks.org/submissionResult.php";

  static String lang = "Python";
  static changeLang(String lang) {
    Compiler.lang = lang;
  }

  static Future<dynamic> gfgCompile(String code, String input) async {
    var data = {'lang': lang, 'code': code, 'input': input, 'save': false};
    Dio dio = new Dio();
    // var r = await dio
    //     .post("https://leetcode.com/playground/api/runcode",
    //         data: FormData.fromMap({
    //           "lang": "python3",
    //           "typed_code": "print(\"Hello World!\")",
    //           "data_input": ""
    //         }),
    //         options: Options(responseType: ResponseType.plain))
    //     .onError((error, stackTrace) {
    //   log(error.toString());
    // });
    var res = await post(
        Uri.parse("https://leetcode.com/playground/api/runcode"),
        headers: {
          "Access-Control-Allow-Origin": "*",
        },
        body: {
          "lang": "python3",
          "typed_code": "print(\"Hello World!\")",
          "data_input": ""
        });
    print(res.statusCode);
    // print(json.decode(r.data));
    // var sid = json.decode(r.data)["sid"];

    // return sid;
  }

  static Future<Map<String, dynamic>> gfgFetchResults(String sid) async {
    var data = {'sid': sid, 'requestType': 'fetchResults'};
    Dio dio = new Dio();
    var r = await dio.post(fetchResultsApi,
        data: FormData.fromMap(data),
        options: Options(responseType: ResponseType.plain));
    return json.decode(r.data);
  }

  static Future<String> leetCodeCompile(String code, String input) async {
    Dio dio = new Dio();
    var r = await dio.get(
        "https://imsudip-weather.herokuapp.com/leetCodeCompile",
        queryParameters: {"lang": lang, "code": code, "input": input},
        options: Options(responseType: ResponseType.plain));
    return json.decode(r.data)["interpret_id"];
  }

  static Future<Map<String, dynamic>> leetCodeFetchResults(String id) async {
    Dio dio = new Dio();
    var r = await dio.get("https://imsudip-weather.herokuapp.com/leetCodeCheck",
        queryParameters: {"token": id},
        options: Options(responseType: ResponseType.plain));
    log(r.data);
    return json.decode(r.data);
  }
}
