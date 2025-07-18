
class CustomersListResponseModel {
  CustomersListResponseModel({
    required this.items,
    this.meta,
    this.userKey,
  });

  final List<Item> items;
  final Meta? meta;
  final dynamic userKey;

  factory CustomersListResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomersListResponseModel(
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      userKey: json["user_key"],
    );
  }
}


class Item {
  Item({
    required this.projectStatus,
    required this.activeServices,
    required this.id,
    required this.firstName,
    required this.lastName,
    this.primaryEmail,
    this.countryCode,
    this.primaryContact,
    this.createdAt,
    required this.customerAssigned,
    this.city,
    this.state,
    this.country,
    required this.divisions,
    required this.companies,
    this.createdBy,
  });

  final ProjectStatus? projectStatus;
  final List<dynamic> activeServices;
  final String id;
  final String firstName;
  final String lastName;
  final String? primaryEmail;
  final int? countryCode;
  final String? primaryContact;
  final DateTime? createdAt;
  final List<CustomerAssigned> customerAssigned;
  final City? city;
  final State? state;
  final Country? country;
  final List<City> divisions;
  final List<Company> companies;
  final dynamic createdBy;

  factory Item.fromJson(Map<String, dynamic> json) {
    // Debug print to inspect country_code
    print('country_code: ${json["country_code"]}, type: ${json["country_code"]?.runtimeType}');

    return Item(
      projectStatus: json["projectStatus"] == null
          ? null
          : ProjectStatus.fromJson(json["projectStatus"]),
      activeServices: json["active_services"] == null
          ? []
          : List<dynamic>.from(json["active_services"]!.map((x) => x)),
      id: json["id"] as String? ?? "",
      firstName: json["first_name"] as String? ?? "",
      lastName: json["last_name"] as String? ?? "",
      primaryEmail: json["primary_email"] as String?,
      countryCode: json["country_code"] == null
          ? null
          : (json["country_code"] is int
          ? json["country_code"] as int
          : json["country_code"] is String
          ? int.tryParse(json["country_code"] as String)
          : null),
      primaryContact: json["primary_contact"] as String?,
      createdAt: json["created_at"] == null
          ? null
          : DateTime.tryParse(json["created_at"] as String),
      customerAssigned: json["customer_assigned"] == null
          ? []
          : List<CustomerAssigned>.from(
          json["customer_assigned"]!.map((x) => CustomerAssigned.fromJson(x))),
      city: json["city"] == null ? null : City.fromJson(json["city"]),
      state: json["state"] == null ? null : State.fromJson(json["state"]),
      country: json["country"] == null ? null : Country.fromJson(json["country"]),
      divisions: json["divisions"] == null
          ? []
          : List<City>.from(json["divisions"]!.map((x) => City.fromJson(x))),
      companies: json["companies"] == null
          ? []
          : List<Company>.from(json["companies"]!.map((x) => Company.fromJson(x))),
      createdBy: json["created_by"],
    );
  }
}

/// Represents a city, used for both individual city and divisions.
class City {
  City({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"] as String? ?? "",
      name: json["name"] as String? ?? "",
    );
  }
}

/// Represents a state, distinct from City.
class State {
  State({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json["id"] as String? ?? "",
      name: json["name"] as String? ?? "",
    );
  }
}

/// Represents a country, distinct from City.
class Country {
  Country({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json["id"] as String? ?? "",
      name: json["name"] as String? ?? "",
    );
  }
}

/// Represents a company associated with a customer.
class Company {
  Company({
    required this.id,
    required this.companyName,
    this.companyEmail,
  });

  final String id;
  final String companyName;
  final String? companyEmail;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json["id"] as String? ?? "",
      companyName: json["company_name"] as String? ?? "",
      companyEmail: json["company_email"] as String?,
    );
  }
}

/// Represents an assigned customer with a user.
class CustomerAssigned {
  CustomerAssigned({
    required this.id,
    this.user,
  });

  final String id;
  final User? user;

  factory CustomerAssigned.fromJson(Map<String, dynamic> json) {
    return CustomerAssigned(
      id: json["id"] as String? ?? "",
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}

/// Represents a user assigned to a customer.
class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.status,
  });

  final String id;
  final String firstName;
  final String lastName;
  final int status;

  factory User.fromJson(Map<String, dynamic> json) {
    print('User status: ${json["status"]}, type: ${json["status"]?.runtimeType}');
    return User(
      id: json["id"] as String? ?? "",
      firstName: json["first_name"] as String? ?? "",
      lastName: json["last_name"] as String? ?? "",
      status: json["status"] is int
          ? json["status"] as int
          : int.tryParse(json["status"]?.toString() ?? '0') ?? 0,
    );
  }
}

/// Represents the project status of a customer.
class ProjectStatus {
  ProjectStatus({
    required this.notStarted,
    required this.inProgress,
    required this.onHold,
  });

  final List<InProgress> notStarted;
  final List<InProgress> inProgress;
  final List<InProgress> onHold;

  factory ProjectStatus.fromJson(Map<String, dynamic> json) {
    return ProjectStatus(
      notStarted: json["not_Started"] == null
          ? []
          : List<InProgress>.from(
          json["not_Started"]!.map((x) => InProgress.fromJson(x))),
      inProgress: json["in_progress"] == null
          ? []
          : List<InProgress>.from(
          json["in_progress"]!.map((x) => InProgress.fromJson(x))),
      onHold: json["on_hold"] == null
          ? []
          : List<InProgress>.from(
          json["on_hold"]!.map((x) => InProgress.fromJson(x))),
    );
  }
}

/// Represents an individual project status entry.
class InProgress {
  InProgress({
    required this.id,
    required this.status,
  });

  final String id;
  final String status;

  factory InProgress.fromJson(Map<String, dynamic> json) {
    return InProgress(
      id: json["id"] as String? ?? "",
      status: json["status"] as String? ?? "",
    );
  }
}

/// Metadata for pagination in the response.
class Meta {
  Meta({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemCount,
  });

  final int currentPage;
  final int itemsPerPage;
  final int totalPages;
  final int totalItems;
  final int itemCount;

  factory Meta.fromJson(Map<String, dynamic> json) {
    print('Meta totalItems: ${json["totalItems"]}, type: ${json["totalItems"]?.runtimeType}');
    return Meta(
      currentPage: json["currentPage"] is int
          ? json["currentPage"] as int
          : int.tryParse(json["currentPage"]?.toString() ?? '0') ?? 0,
      itemsPerPage: json["itemsPerPage"] is int
          ? json["itemsPerPage"] as int
          : int.tryParse(json["itemsPerPage"]?.toString() ?? '0') ?? 0,
      totalPages: json["totalPages"] is int
          ? json["totalPages"] as int
          : int.tryParse(json["totalPages"]?.toString() ?? '0') ?? 0,
      totalItems: json["totalItems"] is int
          ? json["totalItems"] as int
          : int.tryParse(json["totalItems"]?.toString() ?? '0') ?? 0,
      itemCount: json["itemCount"] is int
          ? json["itemCount"] as int
          : int.tryParse(json["itemCount"]?.toString() ?? '0') ?? 0,
    );
  }
}