import 'package:m_commerce/features/common/data/models/product_model.dart';

class ReviewModel {
  String? sId;
  ProductModel? product;
  User? user;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ReviewModel(
      {this.sId,
      this.product,
      this.user,
      this.rating,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['rating'] = rating;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? avatarUrl;

  User({this.sId, this.firstName, this.lastName, this.avatarUrl});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar_url'] = avatarUrl;
    return data;
  }
}
