class CustomerTrashRequestModel {
  final int limit;
  final int page;
  final String search;

  CustomerTrashRequestModel({
    required this.limit,
    required this.page,
    this.search = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
      'search': search,
    };
  }
}
