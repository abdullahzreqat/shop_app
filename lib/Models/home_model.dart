class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners=[];
  List<ProductModel> products=[];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners']
        .forEach((element) => banners.add(BannerModel.fromJson(element)));
    json['products'].forEach((element) => products.add(ProductModel.fromJson(element)  ));
  }
}

class ProductModel {
  int? id;
  dynamic  price;
  dynamic  oldPrice;
  String? image;
  List<dynamic>? images;
  int? discount;
  String? name;
  String? description;
  bool? inFavorite;
  bool? inCart;
  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    images = json['images'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorite = json['in_favorites'];
    inCart= json['in_cart'];
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
