import 'dart:convert';
import 'package:http/http.dart';
import 'package:storesight/infrastructure/config.dart';
import 'package:storesight/infrastructure/exceptions.dart';
import 'package:storesight/infrastructure/local_storage.dart';
import 'package:storesight/infrastructure/request.dart';
import 'package:storesight/infrastructure/utils.dart';
import 'package:storesight/models/file_upload.dart';

class HttpService {
  final ConfigurationService _configuration = ConfigurationService();
  static ConfigModel? _configModel;

  Future<Map<String, dynamic>> doPost(
      {required String url,
      Serialized? pawsRequest,
      Map<String, String>? headers}) async {
    if (await _isDebugEnabled()) {
      printLn('Performing HttpRequest POST at: $url');
      if (pawsRequest != null) {
        printLn('RequestBody: ${pawsRequest.toJson()}');
      }
    }
    headers = await _getHeaders(headers);
    Response response = await post(await _getFullUrl(url),
        headers: headers,
        body: jsonEncode(pawsRequest != null ? pawsRequest.toJson() : {},
            toEncodable: _encode));
    printLn(response.body);
    return (await _decode(response));
  }

  Future<String> doPostRaw(
      {required String url,
      Serialized? pawsRequest,
      Map<String, String>? headers}) async {
    if (await _isDebugEnabled()) {
      printLn('Performing HttpRequest POST at: $url');
      if (pawsRequest != null) {
        printLn('RequestBody: ${pawsRequest.toJson()}');
      }
    }
    headers = await _getHeaders(headers);
    Response response = await post(await _getFullUrl(url),
        headers: headers,
        body: jsonEncode(pawsRequest != null ? pawsRequest.toJson() : {},
            toEncodable: _encode));
    return response.body;
  }

  Future<dynamic> doPatch(
      {required String url,
      Serialized? pawsRequest,
      Map<String, String>? headers}) async {
    var body = pawsRequest?.toJson();
    if (await _isDebugEnabled()) {
      printLn('Performing HttpRequest PATCH at: $url');
      printLn('RequestBody: $body}');
    }
    headers = await _getHeaders(headers);
    Response response = await patch(await _getFullUrl(url),
        headers: headers, body: jsonEncode(body, toEncodable: _encode));
    printLn(response.body);
    return _decode(response);
  }

  Future<dynamic> uploadFile(
      String url, FileUploadRequest fileUploadRequest) async {
    var request = MultipartRequest("POST", await _getFullUrl(url));
    request.headers.addAll(await _getHeaders({}));
    for (var element in fileUploadRequest.files) {
      request.files.add(await MultipartFile.fromPath(
          fileUploadRequest.fileParam, element.path));
    }
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    if (response.statusCode == 200) {
      return jsonDecode(responseString)['message'];
    }
    if (await _isDebugEnabled() || await _logErrors()) {
      printLn(responseString);
    }
    throw ApiException('file-upload-error', 'Error uploading file');
  }

  Future<dynamic> patchNoSerialized(
      {required String url,
      Map<String, dynamic>? pawsRequest,
      Map<String, String>? headers}) async {
    var body = pawsRequest;
    if (await _isDebugEnabled()) {
      printLn('Performing HttpRequest PATCH at: $url');
      printLn('RequestBody: $body}');
    }
    headers = await _getHeaders(headers);
    Response response = await patch(await _getFullUrl(url),
        headers: headers, body: jsonEncode(body, toEncodable: _encode));
    printLn(response.body);
    return _decode(response);
  }

  Future<dynamic> doPut(
      {required String url,
      Serialized? pawsRequest,
      Map<String, String>? headers}) async {
    var body = pawsRequest?.toJson();
    if (await _isDebugEnabled()) {
      printLn('Performing HttpRequest Put at: $url');
      printLn('RequestBody: $body}');
    }
    headers = await _getHeaders(headers);
    Response response = await put(await _getFullUrl(url),
        headers: headers, body: jsonEncode(body, toEncodable: _encode));
    return _decode(response);
  }

  Future<dynamic> doDelete(String url, {Map<String, String>? headers}) async {
    if (await _isDebugEnabled()) {
      printLn('Performing HttpRequest DELETE at: $url');
    }
    headers = await _getHeaders(headers);
    Response response = await delete(await _getFullUrl(url), headers: headers);
    return _decode(response);
  }

  Future<Map<String, dynamic>> doGet(String url,
      {Map<String, String>? headers}) async {
    if (await _isDebugEnabled()) {
      printLn('Performing HttpRequest GET at: $url');
    }
    headers = await _getHeaders(headers);
    Response response = await get(await _getFullUrl(url), headers: headers);
    return _decode(response);
  }

  Future<String> doGetExt(String url, {Map<String, String>? headers}) async {
    if (await _isDebugEnabled()) {
      printLn('Performing HttpRequest GET at: $url');
    }
    Response response = await get(Uri.parse(url),
        headers: headers ??
            {
              'Authorization': getBasicAuthHeader(),
            });
    return response.body;
  }

  String consumerKey = 'ck_0c87fe08cc725eaed9644025a63535cd34c6edcb';
  String consumerSecret = 'cs_8a158c6c08b49650fbb677add3447565c9c20b78';

// Base64 encoding of consumer key and secret for Basic Authentication
  String getBasicAuthHeader() {
    final credentials = '$consumerKey:$consumerSecret';
    final encodedCredentials = base64Encode(utf8.encode(credentials));
    return 'Basic $encodedCredentials';
  }

  Future<String> doGetRaw(String url, {Map<String, String>? headers}) async {
    headers = await _getHeaders(headers);
    Response response = await get(await _getFullUrl(url), headers: headers);
    return response.body;
  }

  Future<Map<String, String>> _getHeaders(Map<String, String>? headers) async {
    headers ??= {};
    String? cookie = await LocalStorage().getString(LocalStorageKeys.authKey);
    String? sessionId =
        await LocalStorage().getString(LocalStorageKeys.sessionKey);
    headers.putIfAbsent('Accept', () => 'application/json');
    headers.putIfAbsent('Content-Type', () => 'application/json');
    headers.putIfAbsent(
        'Cookie', () => "csrftoken=$cookie; sessionid=$sessionId;");
    printLn(headers);
    return headers;
  }

  bool _isErrorResponse(int statusCode) {
    return statusCode != 200 && statusCode != 201;
  }

  Future<Uri> _getFullUrl(String url) async {
    ConfigModel configModel = await _getConfig();
    if (configModel.apiBaseUrl.endsWith('/') && url.startsWith('/')) {
      return Uri.parse(configModel.apiBaseUrl.substring(1) + url);
    }
    if (!configModel.apiBaseUrl.endsWith('/') && !url.startsWith('/')) {
      return Uri.parse('${configModel.apiBaseUrl}/$url');
    }
    return Uri.parse(configModel.apiBaseUrl + url);
  }

  Future<ConfigModel> _getConfig() async {
    _configModel ??= await _configuration.getConfigs();
    return _configModel!;
  }

  Future<bool> _isDebugEnabled() async {
    ConfigModel configModel = await _getConfig();
    return configModel.debugEnabled;
  }

  Future<bool> _logErrors() async {
    ConfigModel configModel = await _getConfig();
    return configModel.logErrors;
  }

  Future<void> checkForErrors(int statusCode, Map<String, dynamic> body,
      {String? url, dynamic reqBody}) async {
    if (_isErrorResponse(statusCode)) {
      if (await _isDebugEnabled() || await _logErrors()) {
        if (!(await _isDebugEnabled())) {
          if (url != null) {
            printLn('URL: $url');
          }
          if (reqBody != null) {
            printLn('RequestBody: $reqBody');
          }
        }
        printLn('HttpErrorStatus: $statusCode');
        printLn('HttpErrorResponse: $body');
      }
      if (statusCode == 401) {
        throw ApiException.fromJson(statusCode, body);
      }
      throw ApiException.fromJson(statusCode, body);
    }
    if (body['success'] != null && !body['success']) {
      throw ApiException.fromJson(statusCode, body);
    } else if (await _isDebugEnabled()) {
      printLn('HttpResponse: $body');
    }
  }

  dynamic _encode(dynamic nonEncodable) {
    if (nonEncodable is DateTime) {
      return nonEncodable.toIso8601String();
    }
    return nonEncodable;
  }

  Future<Map<String, dynamic>> _decode(Response response) async {
    var body = _safeDecodeBody(response);
    await checkForErrors(response.statusCode, body,
        url: response.request!.url.toString());
    return body;
  }

  Map<String, dynamic> _safeDecodeBody(Response response) {
    if (response.body.isEmpty) {
      return {};
    }
    printLn(jsonDecode(utf8.decode(response.bodyBytes)));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
