import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import '../constant/pref_utils.dart';
import 'api_client.dart';
import 'api_exception.dart';
import 'api_methods.dart';

class ApiRequest {
  handleApiError(Response response) async {
    switch (response.statusCode) {
      case 400:
        throw UnauthorisedException();
      case 401:
        throw UnauthorisedException();
      case 402:
        throw UnauthorisedException();
      // case 404:
      //   throw new FetchDataException();
    }
  }

  static send({
    required ApiMethod method,
    required Map<String, dynamic> body,
    Map<String, dynamic>? headers,
    required String route,
    required Map<String, dynamic> queries,
  }) async {
    final api = ApiClient();

    Response? response;

    if (queries != null && queries.isNotEmpty) {
      queries.forEach((key, value) {
        if (value != null) {
          if (route.contains("?")) {
            route += "&$key=$value";
          } else {
            route += "?$key=$value";
          }
        }
      });
    }

    try {
      Uri uri = Uri.parse(api.url(route));
      if (method == ApiMethod.GET) {
        response = await api.client().get(uri);
      } else if (method == ApiMethod.POST) {
        if (headers != null &&
            headers['content-type'] == "multipart/formdata") {
          var request = MultipartRequest('POST', uri);

          request.headers['Authorization'] = 'Bearer ${PrefUtils().getToken()}';

          if (body.isNotEmpty) {
            for (int i = 0; i < body.keys.length; i++) {
              if (body[body.keys.toList()[i]] == null) continue;

              if (body[body.keys.toList()[i]] is File) {
                String fileExtension = (body[body.keys.toList()[i]] as File)
                    .path
                    .split("/")
                    .last
                    .split(".")
                    .last;
                request.files.add(await MultipartFile.fromPath(
                    body.keys.toList()[i],
                    (body[body.keys.toList()[i]] as File).path,
                    contentType: MediaType('image', fileExtension)));
              } else {
                request.fields[body.keys.toList()[i]] =
                    body[body.keys.toList()[i]] as String;
              }
            }

            log("POST: ${request.url}\nBody: ${request.fields}");
            ByteStream responseByteStream = (await request.send()).stream;

            Uint8List responseUint8List = await responseByteStream.toBytes();

            String responseString = String.fromCharCodes(responseUint8List);

            log("<== Response POST: ${request.url}\n $responseString");

            return jsonDecode(responseString);
          }

          return {};
        }
        response = await api.client().post(uri, body: json.encode(body));
      } else if (method == ApiMethod.DELETE) {
        response = await api.client().delete(uri);
      } else if (method == ApiMethod.PUT) {
        response = await api.client().put(uri, body: json.encode(body));
      }

      final responseBody = json.decode(response?.body ?? "{}");

      return responseBody;
    } on SocketException {
      print("Socket exception");
    }
  }
}
