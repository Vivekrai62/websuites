class ProductMasterListRequestModel {
  final int limit;
  final int page;
  final String search;

  ProductMasterListRequestModel({
    required this.limit,
    required this.page,
    required this.search,
  });

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
      'search': search,
    };
  }
}
