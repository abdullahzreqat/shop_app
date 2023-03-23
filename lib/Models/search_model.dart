class SearchModel {
  bool? status;
  SearchDataModel? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel {
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
  List<Product> product = [];

  SearchDataModel.fromJson(Map<String, dynamic> json) {
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
    json["data"].forEach((e) => product.add(Product.fromJson(e)));
  }
}

class Product {
  int? id;
  dynamic  price;
  String? image;
  List<dynamic>? images;
  String? name;
  String? description;
  bool? inFavorite;
  bool? inCart;
  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    images = json['images'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorite = json['in_favorites'];
    inCart= json['in_cart'];
  }
}
