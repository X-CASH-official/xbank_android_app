/**
 * @author snakeway
 * @description:
 * @date :2021/3/23
 */
import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../exception_util.dart';
import '../log_util.dart';
import '../shared_preferences_manager.dart';
import 'base_entity.dart';
import 'base_list_entity.dart';
import 'configs/http_config.dart';
import 'configs/http_key_config.dart';
import 'error_entity.dart';

typedef SuccessCallback<T> = Future<void> Function(T?, BaseEntity);
typedef SuccessListCallback<T> = Future<void> Function(List<T>, BaseListEntity);
typedef ErrorCallback = Future<void> Function(ErrorEntity);

class HttpManager {
  static const int UNKNOWN_ERROR_CODE = -1;
  static const int ANALYZE_ERROR_CODE = -2;
  static const int TIMEOUT_ERROR_CODE = -3;

  static const String RESULT_CACHES_KEY = "resultCaches";

  static HttpManager? _httpManager;

  HttpManager._internal();

  factory HttpManager() => _httpManager ??= HttpManager._internal();

  late Dio _dio;
  late Dio _downloadDio;
  String? _baseUrl;
  int _maxCacheSize = 100;

  final Map<CancelToken, String> _cancelTokens = Map<CancelToken, String>();
  final LinkedHashMap<String, dynamic> resultCaches =
      LinkedHashMap<String, dynamic>();

  void initDio(BaseOptions? baseOptions,
      {bool recoverSaveCaches = true, int? maxCacheSize}) {
    _dio = baseOptions != null ? Dio(baseOptions) : Dio();
    _downloadDio = Dio();
    _baseUrl = baseOptions?.baseUrl;
    if (recoverSaveCaches) {
      recoverResultCaches();
    }
    if (maxCacheSize != null) {
      _maxCacheSize = maxCacheSize;
    }
  }

  Dio get dio => _dio;

  Dio get downloadDio => _downloadDio;

  void addInterceptor(InterceptorsWrapper interceptor) {
    _dio.interceptors.add(interceptor);
  }

  CancelToken? addCancelToken(String? requestKey, bool isCancelable) {
    CancelToken? cancelToken;
    if (requestKey != null && isCancelable) {
      cancelToken = CancelToken();
      _cancelTokens[cancelToken] = requestKey;
    }
    return cancelToken;
  }

  void removeCancelToken(CancelToken cancelToken) {
    _cancelTokens.remove(cancelToken);
  }

  void cancelHttp(String requestKey) {
    List<CancelToken> needCancelTokens = [];
    _cancelTokens.forEach((key, value) {
      if (value == requestKey) {
        needCancelTokens.add(key);
      }
    });
    needCancelTokens.forEach((element) {
      _cancelTokens.remove(element);
    });
  }

  String appendBaseUrl(String url) {
    String newUrl = (_baseUrl ?? "") + url;
    return newUrl;
  }

  void setMaxCacheSize(int value) {
    _maxCacheSize = value;
  }

  String getResultCacheUrlKey(String url, String? query, String? data) {
    return (url + (query?.toString() ?? "") + (data?.toString() ?? ""))
        .replaceAll(" ", "");
  }

  dynamic getResultCache(String key) {
    return resultCaches[key];
  }

  void removeResultCache(String key) {
    resultCaches.remove(key);
  }

  void clearResultCaches() {
    resultCaches.clear();
  }

  void recoverResultCaches() {
    Map? map = SharedPreferencesManager().getObject(RESULT_CACHES_KEY);
    if (map != null) {
      resultCaches.clear();
      resultCaches.addAll(map as Map<String, dynamic>);
    }
  }

  Future<void> saveResultCaches() async {
    await SharedPreferencesManager()
        .putObject(RESULT_CACHES_KEY, resultCaches);
  }

  Future<void> addResultCache(String url, dynamic data) async {
    if (resultCaches.length > _maxCacheSize) {
      resultCaches.remove(resultCaches.keys.first);
    }
    resultCaches[url] = data;
    await saveResultCaches();
  }

  Future<dynamic> request<T>(String method, String url,
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
      ProcessSuccessResponseData? processSuccessResponseData,
      ProcessErrorStatus? processErrorStatus,
      HttpKeyConfig? httpKeyConfig,
      dynamic responseExtra}) async {
    processSuccessResponseData =
        processSuccessResponseData ?? HttpConfig.processSuccessResponseData;
    processErrorStatus = processErrorStatus ?? HttpConfig.processErrorStatus;
    httpKeyConfig = httpKeyConfig ?? HttpConfig.httpKeyConfig;
    CancelToken? cancelToken;
    String urlKey = getResultCacheUrlKey(
        url, query?.toString() ?? "", data?.toString() ?? "");
    try {
      if (showLog) {
        LogUtil.v("requestUrl:" + url);
        LogUtil.v("query:" + (query?.toString() ?? ""));
        LogUtil.v("data:" + (data?.toString() ?? ""));
      }
      cancelToken = addCancelToken(requestKey, isCancelable);
      Response response = await _dio.request(
          appendBase ? appendBaseUrl(url) : url,
          queryParameters: query,
          data: isFormRequest
              ? formData
              : (convertDataToJson ? jsonEncode(data) : data),
          cancelToken: cancelToken,
          options: Options(method: method, headers: headers));
      if (showLog) {
        LogUtil.v("headers:" + response.headers.toString());
        LogUtil.v(
            "responseData:" + response.toString() + ";" + "requestUrl:" + url);
      }
      int statusCode = response.statusCode!;
      if (httpKeyConfig.successHttpCodes.contains(statusCode)) {
        dynamic data = processSuccessResponseData != null
            ? await processSuccessResponseData.call(response, responseExtra)
            : response.data;
        dynamic result = await processData<T>(
            processResponse,
            isList,
            successCallback,
            successListCallback,
            errorCallback,
            processErrorStatus,
            httpKeyConfig,
            data,
            response,
            statusCode,
            cacheResult,
            useCache,
            urlKey);
        if (result != null) {
          return result;
        }
      } else {
        await handleStatus(statusCode, errorCallback, response,
            processErrorStatus, httpKeyConfig);
      }
    } catch (e, s) {
      ExceptionUtil.printException(e, s);
      if (e is DioError) {
        if (cacheResult && useCache) {
          dynamic data = getResultCache(urlKey);
          if (data != null) {
            dynamic result = await processData<T>(
                processResponse,
                isList,
                successCallback,
                successListCallback,
                errorCallback,
                processErrorStatus,
                httpKeyConfig,
                data,
                null,
                200,
                cacheResult,
                useCache,
                urlKey);
            if (result != null) {
              return result;
            }
          }
        }
        await handleDioError(
            e, errorCallback, processErrorStatus, httpKeyConfig);
      } else {
        await doErrorCallback(
            errorCallback, UNKNOWN_ERROR_CODE, httpKeyConfig.httpUnknownError);
      }
    } finally {
      if (cancelToken != null) {
        removeCancelToken(cancelToken);
      }
    }
    return null;
  }

  Future<dynamic> processData<T>(
      bool processResponse,
      bool isList,
      SuccessCallback<T>? successCallback,
      SuccessListCallback<T>? successListCallback,
      ErrorCallback? errorCallback,
      ProcessErrorStatus processErrorStatus,
      HttpKeyConfig httpKeyConfig,
      dynamic data,
      Response? response,
      int statusCode,
      bool cacheResult,
      bool useCache,
      String urlKey) async {
    try {
      if (!processResponse) {
        await successCallback?.call(
            data,
            BaseEntity(
                code: httpKeyConfig.successJsonCodes.length > 0
                    ? httpKeyConfig.successJsonCodes[0]
                    : 0,
                data: data,
                httpKeyConfig: httpKeyConfig,
                response: response));
        return data;
      }
      if (isList) {
        BaseListEntity<T> baseListEntity =
            BaseListEntity<T>.fromJson(data, httpKeyConfig: httpKeyConfig);
        baseListEntity.response = response;
        if (baseListEntity.success) {
          await successListCallback?.call(baseListEntity.data, baseListEntity);
          if (cacheResult) {
            await addResultCache(urlKey, data);
          }
          return baseListEntity.data;
        } else {
          await processErrorStatus.call(baseListEntity.code, null, response,
              isJsonError: true);
          await doErrorCallback(
              errorCallback, statusCode, baseListEntity.msg ?? "");
        }
      } else {
        BaseEntity<T> baseEntity =
            BaseEntity<T>.fromJson(data, httpKeyConfig: httpKeyConfig);
        baseEntity.response = response;
        if (baseEntity.success) {
          await successCallback?.call(baseEntity.data, baseEntity);
          if (cacheResult) {
            await addResultCache(urlKey,data);
          }
          return baseEntity.data;
        } else {
          await processErrorStatus.call(baseEntity.code, null, response,
              isJsonError: true);
          await doErrorCallback(
              errorCallback, statusCode, baseEntity.msg ?? "");
        }
      }
    } catch (e, s) {
      ExceptionUtil.printException(e, s);
      await doErrorCallback(
          errorCallback, ANALYZE_ERROR_CODE, httpKeyConfig.httpAnalyzeError);
    }
    return null;
  }

  Future<void> doErrorCallback(
      ErrorCallback? errorCallback, int code, String msg) async {
    if (errorCallback != null) {
      await errorCallback(ErrorEntity(code: code, msg: msg));
    }
  }

  Future<void> handleDioError(
      DioError? error,
      ErrorCallback? errorCallback,
      ProcessErrorStatus processErrorStatus,
      HttpKeyConfig httpKeyConfig) async {
    if (error == null) {
      await doErrorCallback(
          errorCallback, UNKNOWN_ERROR_CODE, httpKeyConfig.httpUnknownError);
      return;
    }
    switch (error.type) {
      case DioErrorType.cancel:
        break;
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        // case DioErrorType.CANCEL:
        //   break;
        // case DioErrorType.CONNECT_TIMEOUT:
        // case DioErrorType.SEND_TIMEOUT:
        // case DioErrorType.RECEIVE_TIMEOUT:
        await doErrorCallback(
            errorCallback, TIMEOUT_ERROR_CODE, httpKeyConfig.httpUnknownError);
        break;
      default:
        await handlerUnknownError(
            error, errorCallback, processErrorStatus, httpKeyConfig);
        break;
    }
  }

  Future<void> handlerUnknownError(
      DioError? error,
      ErrorCallback? errorCallback,
      ProcessErrorStatus processErrorStatus,
      HttpKeyConfig httpKeyConfig) async {
    if (error == null) {
      return;
    }
    if (error.response == null) {
      await doErrorCallback(
          errorCallback, UNKNOWN_ERROR_CODE, httpKeyConfig.httpUnknownError);
      return;
    }
    try {
      int errorCode = error.response!.statusCode!;
      await handleStatus(errorCode, errorCallback, error.response,
          processErrorStatus, httpKeyConfig);
    } catch (e, s) {
      ExceptionUtil.printException(e, s);
      await doErrorCallback(
          errorCallback, UNKNOWN_ERROR_CODE, httpKeyConfig.httpUnknownError);
    }
  }

  Future<void> handleStatus(
      int errorCode,
      ErrorCallback? errorCallback,
      Response? response,
      ProcessErrorStatus? processErrorStatus,
      HttpKeyConfig httpKeyConfig) async {
    if (errorCallback == null) {
      return;
    }
    if (processErrorStatus != null) {
      await processErrorStatus.call(errorCode, errorCallback, response);
    } else {
      switch (errorCode) {
        case 404:
          await errorCallback(
              ErrorEntity(code: errorCode, msg: httpKeyConfig.http404Error));
          break;
        case 500:
          await errorCallback(
              ErrorEntity(code: errorCode, msg: httpKeyConfig.httpServerError));
          break;
        default:
          await errorCallback(ErrorEntity(
              code: errorCode, msg: httpKeyConfig.httpUnknownError));
          break;
      }
    }
  }
}
