class UserModel {
  String status;
  String user_id;
  String refer_earn;
  String error;
  String code;
  Details details;

  UserModel(
      {this.code,
      this.status,
      this.user_id,
      this.refer_earn,
      this.error,
      this.details});

  factory UserModel.fromJson(Map<String, dynamic> jsonMap) {
    return UserModel(
        user_id: jsonMap['user_id'],
        refer_earn: jsonMap['refer_earn'],
        details: jsonMap['details']);
  }

  Map<String, dynamic> toJson() =>
      {'user_id': user_id, 'refer_earn': refer_earn, 'details': details};
}

class Details {
  String id;
  String date_created;
  String date_modified;
  String email;
  String first_name;
  String last_name;
  String username;
  String role;
  Billing billing;
  Shipping shipping;
  bool is_paying_customer;
  int orders_count;
  String total_spent;
  String avatar_url;
  MetaData meta_data;

  Details(
      {this.id,
      this.date_created,
      this.date_modified,
      this.email,
      this.first_name,
      this.last_name,
      this.username,
      this.role,
      this.billing,
      this.shipping,
      this.is_paying_customer,
      this.orders_count,
      this.total_spent,
      this.avatar_url,
      this.meta_data});

  factory Details.fromJson(Map<String, dynamic> jsonMap) {
    return Details(
      id: jsonMap['id'],
      date_created: jsonMap['date_created'],
      date_modified: jsonMap['date_modified'],
      email: jsonMap['email'],
      first_name: jsonMap['first_name'],
      last_name: jsonMap['last_name'],
      username: jsonMap['username'],
      role: jsonMap['role'],
      billing: jsonMap['billing'],
      shipping: jsonMap['shipping'],
      is_paying_customer: jsonMap['is_paying_customer'],
      orders_count: jsonMap['orders_count'],
      total_spent: jsonMap['total_spent'],
      avatar_url: jsonMap['avatar_url'],
      meta_data: jsonMap['meta_data'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_created': date_created,
        'date_modified': date_modified,
        'email': email,
        'first_name': first_name,
        'last_name': last_name,
        'username': username,
        'role': role,
        'billing': billing,
        'shipping': shipping,
        'is_paying_customer': is_paying_customer,
        'orders_count': orders_count,
        'total_spent': total_spent,
        'avatar_url': avatar_url,
        'meta_data': meta_data,
      };
}

class Billing {
  String first_name;
  String last_name;
  String company;
  String address_1;
  String address_2;
  String city;
  String postcode;
  String country;
  String state;
  String email;
  String phone;

  Billing(
      {this.first_name,
      this.last_name,
      this.company,
      this.address_1,
      this.address_2,
      this.city,
      this.postcode,
      this.country,
      this.state,
      this.email,
      this.phone});
  factory Billing.fromJson(Map<String, dynamic> jsonMap) {
    return Billing(
      first_name: jsonMap['first_name'],
      last_name: jsonMap['last_name'],
      company: jsonMap['company'],
      address_1: jsonMap['address_1'],
      address_2: jsonMap['address_2'],
      city: jsonMap['city'],
      postcode: jsonMap['postcode'],
      country: jsonMap['country'],
      state: jsonMap['state'],
      email: jsonMap['email'],
      phone: jsonMap['phone'],
    );
  }
  Map<String, dynamic> toJson() => {
        'first_name': first_name,
        'last_name': last_name,
        'company': company,
        'address_1': address_1,
        'address_2': address_2,
        'city': city,
        'postcode': postcode,
        'country': country,
        'state': state,
        'email': email,
        'phone': phone,
      };
}

class Shipping {
  String first_name;
  String last_name;
  String company;
  String address_1;
  String address_2;
  String city;
  String postcode;
  String country;
  String state;

  Shipping(
      {this.first_name,
      this.last_name,
      this.company,
      this.address_1,
      this.address_2,
      this.city,
      this.postcode,
      this.country,
      this.state});

  factory Shipping.fromJson(Map<String, dynamic> jsonMap) {
    return Shipping(
      first_name: jsonMap['first_name'],
      last_name: jsonMap['last_name'],
      company: jsonMap['company'],
      address_1: jsonMap['address_1'],
      address_2: jsonMap['address_2'],
      city: jsonMap['city'],
      postcode: jsonMap['postcode'],
      country: jsonMap['country'],
      state: jsonMap['state'],
    );
  }
  Map<String, dynamic> toJson() => {
        'first_name': first_name,
        'last_name': last_name,
        'company': company,
        'address_1': address_1,
        'address_2': address_2,
        'city': city,
        'postcode': postcode,
        'country': country,
        'state': state,
      };
}

class MetaData {
  String id;
  String key;
  String value;

  MetaData({this.id, this.key, this.value});

  factory MetaData.fromJson(Map<String, dynamic> jsonMap) {
    return MetaData(
      id: jsonMap['id'],
      key: jsonMap['key'],
      value: jsonMap['value'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'value': value,
      };
}
