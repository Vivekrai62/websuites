// class LoggerInterceptor implements InterceptorContract {
//   @override
//   Future<BaseRequest> interceptRequest({
//     required BaseRequest request,
//   }) async {
//     print('----- Request -----');
//     print(request.toString());
//     print(request.headers.toString());
//     return request;
//   }
//
//   @override
//   Future<BaseResponse> interceptResponse({
//     required BaseResponse response,
//   }) async {
//     log('----- Response -----');
//     log('Code: ${response.statusCode}');
//     if (response is Response) {
//       log((response).body);
//     }
//     return response;
//   }
//
//
// }
