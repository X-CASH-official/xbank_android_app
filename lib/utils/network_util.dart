import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:framework/utils/network/configs/http_config.dart';
import 'package:framework/utils/network/configs/http_key_config.dart';
import 'package:framework/utils/network/error_entity.dart';
import 'package:framework/utils/network/http_manager.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/url_config.dart';
import 'package:x_bank/controllers/extra/application_controller.dart';

class NetworkUtil {
  static const String http_404_error = "Request address error";
  static const String http_server_error = "Service error";

  static const String code_key_default = "code";
  static const String data_key_default = "data";
  static const String msg_key_default = "message";
  static const List<int> success_http_codes = [200, 201];
  static const List<int> success_json_codes = [0];

  static HttpKeyConfig httpKeyConfig = HttpKeyConfig(
      successHttpCodes: success_http_codes,
      successJsonCodes: success_json_codes,
      codeKey: code_key_default,
      dataKey: data_key_default,
      msgKey: msg_key_default);

  static Future<dynamic> request<T>(String method, String url,
      {Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      FormData? formData,
      String? requestKey,
      bool isFormRequest = false,
      bool isCancelable = true,
      bool appendBase = true,
      bool isList = false,
      bool showLog = true,
      bool processResponse = true,
      bool convertDataToJson = true,
      bool cacheResult = false,
      bool useCache = false,
      Map<String, dynamic>? headers,
      SuccessCallback<T>? successCallback,
      SuccessListCallback<T>? successListCallback,
      ErrorCallback? errorCallback,
      ProcessSuccessResponseData processSuccessResponseData =
          processSuccessResponseData,
      ProcessErrorStatus processErrorStatus = processErrorStatus,
      HttpKeyConfig? httpKeyConfig,
      dynamic responseExtra}) async {
    Map<String, dynamic>? theHeaders = headers;
    if (theHeaders == null && convertDataToJson) {
      theHeaders = Map<String, dynamic>();
      theHeaders["content-type"] = "application/json";
    }
    HttpKeyConfig theHttpKeyConfig = httpKeyConfig ?? NetworkUtil.httpKeyConfig;
    return await HttpManager().request(method, url,
        query: query,
        data: data,
        formData: formData,
        requestKey: requestKey,
        isFormRequest: isFormRequest,
        isCancelable: isCancelable,
        appendBase: appendBase,
        isList: isList,
        showLog: showLog,
        processResponse: processResponse,
        convertDataToJson: convertDataToJson,
        cacheResult: cacheResult,
        useCache: useCache,
        headers: theHeaders,
        successCallback: successCallback,
        successListCallback: successListCallback,
        errorCallback: errorCallback,
        processSuccessResponseData: processSuccessResponseData,
        processErrorStatus: processErrorStatus,
        httpKeyConfig: theHttpKeyConfig,
        responseExtra: responseExtra);
  }

  static Future<dynamic> processSuccessResponseData(
      Response response, dynamic responseExtra,
      {bool convertToJson = true}) async {
    dynamic data;
    String contentType = response.headers.value("content-type") ?? "text/plain";
    if (convertToJson && response.data != "" && !contentType.contains("json")) {
      data = jsonDecode(response.data.toString());
    } else {
      data = response.data;
    }
    return data;
  }

  static Future<void> processErrorStatus(
      int errorCode, ErrorCallback? error, Response? response,
      {bool isJsonError = false}) async {
    if (isJsonError) {
      switch (errorCode) {
        default:
          break;
      }
      return;
    }
    if (error == null) {
      return;
    }
    switch (errorCode) {
      case 401:
        if (response != null &&
            (response.realUri.toString().contains(UrlConfig.users_sign_up) ||
                response.realUri.toString().contains(UrlConfig.users_sign_in) ||
                response.realUri
                    .toString()
                    .contains(UrlConfig.users_password))) {
          await decodeMessage(response, errorCode, error);
        } else {
          String? message = await decodeMessage(response, errorCode, null);
          bool tokenError = true;
          if (response != null) {
            List<String> strs = response.realUri
                .toString()
                .replaceAll(UrlConfig.getBaseUrl() + "/", "")
                .split("/");
            if (strs.length >= 3 &&
                strs[0] == "users" &&
                strs[2] == "account") {
              if (message != null && !message.contains("invalid")) {
                tokenError = false;
              }
            } else if (strs.length >= 5 &&
                strs[0] == "users" &&
                strs[2] == "accounts" &&
                strs[4] == "transfers") {
              if (message != null && !message.contains("invalid")) {
                tokenError = false;
              }
            }
          }
          if (tokenError) {
            await error(ErrorEntity(code: errorCode, msg: ""));
            ApplicationController.getInstance().loginOut(
                AppConfig.navigatorStateKey.currentContext!,
                showTokenTips: true);
          } else {
            if (error != null) {
              await error(
                ErrorEntity(
                  code: errorCode,
                  msg: message?.toString() ?? "",
                ),
              );
            }
          }
        }
        break;
      case 404:
        await error(ErrorEntity(code: errorCode, msg: http_404_error));
        break;
      case 500:
        await error(ErrorEntity(code: errorCode, msg: http_server_error));
        break;
      default:
        await decodeMessage(response, errorCode, error);
        break;
    }
  }

  static Future<String?> decodeMessage(
      Response? response, int errorCode, ErrorCallback? error) async {
    dynamic data;
    if (response != null) {
      String contentType =
          response.headers.value("content-type") ?? "text/plain";
      if (response.data != "" && !contentType.contains("json")) {
        data = jsonDecode(response.data.toString());
      } else {
        data = response.data;
      }
    }
    dynamic message;
    if (data != null &&
        data["error"] != null &&
        data["error"]["message"] != null) {
      message = data["error"]["message"];
    }
    if (error != null) {
      await error(
        ErrorEntity(
          code: errorCode,
          msg: message?.toString() ?? "",
        ),
      );
    }
    return message;
  }
}
