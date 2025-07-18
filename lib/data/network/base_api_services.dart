

abstract class BaseApiServices {

  Future<dynamic> getApi(String url);

  Future<dynamic> postApiResponse(String url, dynamic data);

  Future<dynamic> deleteApiResponse(String url);

  Future<dynamic> patchApi(String url,dynamic data);

}