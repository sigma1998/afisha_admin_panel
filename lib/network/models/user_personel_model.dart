class UserPersonalModel {
  int? id;
  String? fullname;
  String? username;
  String? phone;
  String? status;
  String? address;
  int? productNumber;
  String? phoneVerifiedAt;
  int? role;
  String? adminUserCategory;
  String? createdAt;
  String? updatedAt;
  String? avatar;
  String? blocked;
  int? views;

  UserPersonalModel(
      {this.id,
        this.fullname,
        this.username,
        this.phone,
        this.status,
        this.address,
        this.productNumber,
        this.phoneVerifiedAt,
        this.role,
        this.adminUserCategory,
        this.createdAt,
        this.updatedAt,
        this.avatar,
        this.blocked,
        this.views});

  UserPersonalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    phone = json['phone'];
    status = json['status'];
    address = json['address'];
    productNumber = json['product_number'];
    phoneVerifiedAt = json['phone_verified_at'];
    role = json['role'];
    adminUserCategory = json['admin_user_category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    avatar = json['avatar'];
    blocked = json['blocked'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['username'] = username;
    data['phone'] = phone;
    data['status'] = status;
    data['address'] = address;
    data['product_number'] = productNumber;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['role'] = role;
    data['admin_user_category'] = adminUserCategory;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['avatar'] = avatar;
    data['blocked'] = blocked;
    data['views'] = views;
    return data;
  }
}