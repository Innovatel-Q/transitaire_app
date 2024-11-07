// To parse this JSON data, do
//
//     final orderItemsResponse = orderItemsResponseFromJson(jsonString);

import 'dart:convert';

OrderItemsResponse orderItemsResponseFromJson(String str) => OrderItemsResponse.fromJson(json.decode(str));

String orderItemsResponseToJson(OrderItemsResponse data) => json.encode(data.toJson());

class OrderItemsResponse {
  
    OrderItems orderItems;

    OrderItemsResponse({
        required this.orderItems,
    });

    factory OrderItemsResponse.fromJson(Map<String, dynamic> json) => OrderItemsResponse(
        orderItems: OrderItems.fromJson(json["OrderItems"]),
    );

    Map<String, dynamic> toJson() => {
        "OrderItems": orderItems.toJson(),
    };
}

class OrderItems {
    int? id;
    int? orderId;
    Product? product;
    Shop? shop;
    String? orderItemsCode;
    int? quantity;
    double? price;
    Forwarder? forwarder;
    dynamic destinationContry;
    String? fraisInterne;
    dynamic fromSupplierToForwardingAgent;
    dynamic statusTransitaireToCity;
    DateTime? createdAt;
    DateTime? updatedAt;

    OrderItems({
        this.id,
        this.orderId,
        this.product,
        this.shop,
        this.orderItemsCode,
        this.quantity,
        this.price,
        this.forwarder,
        this.destinationContry,
        this.fraisInterne,
        this.fromSupplierToForwardingAgent,
        this.statusTransitaireToCity,
        this.createdAt,
        this.updatedAt,
    });

    factory OrderItems.fromJson(Map<String, dynamic> json) => OrderItems(
        id: json["id"],
        orderId: json["order_id"],
        product: json["product"] != null ? Product.fromJson(json["product"]) : null,
        shop: json["shop"] != null ? Shop.fromJson(json["shop"]) : null,
        orderItemsCode: json["order_items_code"],
        quantity: json["quantity"],
        price: json["price"],
        forwarder: json["forwarder"] != null ? Forwarder.fromJson(json["forwarder"]) : null,
        destinationContry: json["destination_contry"],
        fraisInterne: json["frais_interne"],
        fromSupplierToForwardingAgent: json["from_supplier_to_forwardingAgent"],
        statusTransitaireToCity: json["status_transitaire_to_city"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product": product?.toJson(),
        "shop": shop?.toJson(),
        "order_items_code": orderItemsCode,
        "quantity": quantity,
        "price": price,
        "forwarder": forwarder?.toJson(),
        "destination_contry": destinationContry,
        "frais_interne": fraisInterne,
        "from_supplier_to_forwardingAgent": fromSupplierToForwardingAgent,
        "status_transitaire_to_city": statusTransitaireToCity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Forwarder {
    int? id;
    String? firstname;
    String? lastname;
    String? phoneNumber;
    dynamic adresse;
    dynamic avatar;
    String? role;
    String? email;
    DateTime? emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    dynamic country;
    int? status;

    Forwarder({
        this.id,
        this.firstname,
        this.lastname,
        this.phoneNumber,
        this.adresse,
        this.avatar,
        this.role,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.country,
        this.status,
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
        emailVerifiedAt: json["email_verified_at"] != null ? DateTime.parse(json["email_verified_at"]) : null,
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
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
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "country": country,
        "status": status,
    };
}

class Product {
    int? id;
    int? shopId;
    int? categoryId;
    String? sku;
    String? name;
    int? price;
    String? mainImage;
    String? video;
    String? description;
    double? productWeight;
    double? productHeight;
    int? productWidth;
    int? productLength;
    String? status;
    int? available;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    Product({
        this.id,
        this.shopId,
        this.categoryId,
        this.sku,
        this.name,
        this.price,
        this.mainImage,
        this.video,
        this.description,
        this.productWeight,
        this.productHeight,
        this.productWidth,
        this.productLength,
        this.status,
        this.available,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        shopId: json["shop_id"],
        categoryId: json["category_id"],
        sku: json["sku"],
        name: json["name"],
        price: json["price"],
        mainImage: json["main_image"],
        video: json["video"],
        description: json["description"],
        productWeight: json["product_weight"]?.toDouble(),
        productHeight: json["product_height"]?.toDouble(),
        productWidth: json["product_width"],
        productLength: json["product_length"],
        status: json["status"],
        available: json["available"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Shop {
    int? id;
    int? userId;
    String? companyName;
    String? salesManagerName;
    String? companyRegistration;
    String? businessLicense;
    String? phoneNumber;
    String? emailAddress;
    String? logo;
    String? banner;
    dynamic bankTransferDetails;
    dynamic paypalDetails;
    dynamic westernUnionDetails;
    String? balance;
    String? deadBalance;
    String? fraisInterne;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? isActive;

    Shop({
        this.id,
        this.userId,
        this.companyName,
        this.salesManagerName,
        this.companyRegistration,
        this.businessLicense,
        this.phoneNumber,
        this.emailAddress,
        this.logo,
        this.banner,
        this.bankTransferDetails,
        this.paypalDetails,
        this.westernUnionDetails,
        this.balance,
        this.deadBalance,
        this.fraisInterne,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.isActive,
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
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_active": isActive,
    };
}