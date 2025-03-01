import 'package:m_commerce/features/common/data/models/product_model.dart';

class ProductDetailsListModel {
  String? msg;
  List<ProductDetailsModel>? productDetailsList;

  ProductDetailsListModel({this.msg, this.productDetailsList});

  ProductDetailsListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productDetailsList = <ProductDetailsModel>[];
      json['data'].forEach((v) {
        productDetailsList!.add(ProductDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (productDetailsList != null) {
      data['data'] = productDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetailsModel {
  int? id;
  String? img1;
  String? img2;
  String? img3;
  String? img4;
  String? des;
  String? color;
  String? size;
  int? productId;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;

  ProductDetailsModel(
      {this.id,
      this.img1,
      this.img2,
      this.img3,
      this.img4,
      this.des,
      this.color,
      this.size,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.product});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img1 = json['img1'];
    img2 = json['img2'];
    img3 = json['img3'];
    img4 = json['img4'];
    des = json['des'];
    color = json['color'];
    size = json['size'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img1'] = img1;
    data['img2'] = img2;
    data['img3'] = img3;
    data['img4'] = img4;
    data['des'] = des;
    data['color'] = color;
    data['size'] = size;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
