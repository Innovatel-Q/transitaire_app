// To parse this JSON data, do
//
//     final orderItemsList = orderItemsListFromJson(jsonString);

import 'dart:convert';

OrderItemsList orderItemsListFromJson(String str) => OrderItemsList.fromJson(json.decode(str));

String orderItemsListToJson(OrderItemsList data) => json.encode(data.toJson());

class OrderItemsList {
    List<Datum> data;

    OrderItemsList({
        required this.data,
    });

    factory OrderItemsList.fromJson(Map<String, dynamic> json) => OrderItemsList(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    int orderId;
    Product product;
    Shop shop;
    String orderItemsCode;
    int quantity;
    double price;  // Changed from int to double
    Forwarder forwarder;
    dynamic destinationContry;
    String fraisInterne;
    dynamic statusTransitaireToCity;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.orderId,
        required this.product,
        required this.shop,
        required this.orderItemsCode,
        required this.quantity,
        required this.price,
        required this.forwarder,
        required this.destinationContry,
        required this.fraisInterne,
        required this.statusTransitaireToCity,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        orderId: json["order_id"],
        product: Product.fromJson(json["product"]),
        shop: Shop.fromJson(json["shop"]),
        orderItemsCode: json["order_items_code"],
        quantity: json["quantity"],
        price: (json["price"] as num).toDouble(),  // Convert to double
        forwarder: Forwarder.fromJson(json["forwarder"]),
        destinationContry: json["destination_contry"],
        fraisInterne: json["frais_interne"],
        statusTransitaireToCity: json["status_transitaire_to_city"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product": product.toJson(),
        "shop": shop.toJson(),
        "order_items_code": orderItemsCode,
        "quantity": quantity,
        "price": price,
        "forwarder": forwarder.toJson(),
        "destination_contry": destinationContry,
        "frais_interne": fraisInterne,
        "status_transitaire_to_city": statusTransitaireToCity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Forwarder {
    int id;
    String firstname;
    String lastname;
    String phoneNumber;
    dynamic adresse;
    dynamic avatar;
    String role;
    String email;
    DateTime emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    dynamic country;
    int status;

    Forwarder({
        required this.id,
        required this.firstname,
        required this.lastname,
        required this.phoneNumber,
        required this.adresse,
        required this.avatar,
        required this.role,
        required this.email,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.country,
        required this.status,
    });

    factory Forwarder.fromJson(Map<String, dynamic> json) => Forwarder(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phoneNumber: json["phone_number"],
        adresse: json["adresse"],
        avatar: json["avatar"],
        role: json["role"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        country: json["country"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "phone_number": phoneNumber,
        "adresse": adresse,
        "avatar": avatar,
        "role": role,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "country": country,
        "status": status,
    };
}

class Product {
    int id;
    int shopId;
    int categoryId;
    String sku;
    String name;
    int price;
    String? mainImage;  // Changé en String nullable
    String? video;  // Changé en String nullable
    String description;
    double productWeight;
    double productHeight;
    double productWidth;  // Changed from int to double
    double productLength;  // Changed from int to double
    String status;
    int available;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;

    Product({
        required this.id,
        required this.shopId,
        required this.categoryId,
        required this.sku,
        required this.name,
        required this.price,
        required this.mainImage,  // Rendu optionnel
        required this.video,  // Rendu optionnel
        required this.description,
        required this.productWeight,
        required this.productHeight,
        required this.productWidth,
        required this.productLength,
        required this.status,
        required this.available,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        shopId: json["shop_id"],
        categoryId: json["category_id"],
        sku: json["sku"],
        name: json["name"],
        price: json["price"],
        mainImage: json["main_image"] as String?,  // Conversion sûre
        video: json["video"] as String?,  // Conversion sûre
        description: json["description"],
        productWeight: json["product_weight"]?.toDouble(),
        productHeight: json["product_height"]?.toDouble(),
        productWidth: json["product_width"]?.toDouble(),  // Changed to toDouble()
        productLength: json["product_length"]?.toDouble(),  // Changed to toDouble()
        status: json["status"],
        available: json["available"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "category_id": categoryId,
        "sku": sku,
        "name": name,
        "price": price,
        "main_image": mainImage,
        "video": video,
        "description": description,
        "product_weight": productWeight,
        "product_height": productHeight,
        "product_width": productWidth,
        "product_length": productLength,
        "status": status,
        "available": available,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Shop {
    int id;
    int userId;
    String companyName;
    String salesManagerName;
    String companyRegistration;
    String businessLicense;
    String phoneNumber;
    String emailAddress;
    String logo;
    String banner;
    dynamic bankTransferDetails;
    dynamic paypalDetails;
    dynamic westernUnionDetails;
    String balance;
    String deadBalance;
    String fraisInterne;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;
    bool isActive;

    Shop({
        required this.id,
        required this.userId,
        required this.companyName,
        required this.salesManagerName,
        required this.companyRegistration,
        required this.businessLicense,
        required this.phoneNumber,
        required this.emailAddress,
        required this.logo,
        required this.banner,
        required this.bankTransferDetails,
        required this.paypalDetails,
        required this.westernUnionDetails,
        required this.balance,
        required this.deadBalance,
        required this.fraisInterne,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.isActive,
    });

    factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        userId: json["user_id"],
        companyName: json["company_name"],
        salesManagerName: json["sales_manager_name"],
        companyRegistration: json["company_registration"],
        businessLicense: json["business_license"],
        phoneNumber: json["phone_number"],
        emailAddress: json["email_address"],
        logo: json["logo"],
        banner: json["banner"],
        bankTransferDetails: json["bank_transfer_details"],
        paypalDetails: json["paypal_details"],
        westernUnionDetails: json["western_union_details"],
        balance: json["balance"],
        deadBalance: json["dead_balance"],
        fraisInterne: json["frais_interne"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company_name": companyName,
        "sales_manager_name": salesManagerName,
        "company_registration": companyRegistration,
        "business_license": businessLicense,
        "phone_number": phoneNumber,
        "email_address": emailAddress,
        "logo": logo,
        "banner": banner,
        "bank_transfer_details": bankTransferDetails,
        "paypal_details": paypalDetails,
        "western_union_details": westernUnionDetails,
        "balance": balance,
        "dead_balance": deadBalance,
        "frais_interne": fraisInterne,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_active": isActive,
    };
}
