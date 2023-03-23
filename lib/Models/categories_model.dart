class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;
  int? total;
  int? perPage;
  String? firstPageUrl;
  String? nextPageUrl;
  String? prevPageUrl;
  String? lastPageUrl;
  List<CategoriesData> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    from = json['from'];
    to = json['to'];
    total = json['total'];
    perPage = json['per_page'];
    firstPageUrl = json['first_page_url'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    lastPageUrl = json['last_page_url'];
    json["data"].forEach((e) => data.add(CategoriesData.fromJson(e)));
  }
}

class CategoriesData {
  int? id;
  String? name;
  String? image;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
