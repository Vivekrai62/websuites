class MasterCitiesRequestModel {
  MasterCitiesRequestModel({
    required this.state,
    required this.country,
    required this.search,
    required this.status,
    required this.page,
  });

  final dynamic state;
  final dynamic country;
  final String? search;
  final dynamic status;
  final int? page;

  factory MasterCitiesRequestModel.fromJson(Map<String, dynamic> json){
    return MasterCitiesRequestModel(
      state: json["state"],
      country: json["country"],
      search: json["search"],
      status: json["status"],
      page: json["page"],
    );
  }

}

/*
{
	"state": null,
	"country": null,
	"search": "",
	"status": null,
	"page": 1
}*/