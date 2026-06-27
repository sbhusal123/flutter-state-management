// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int page;
    int perPage;
    int total;
    int totalPages;
    List<Datum> data;
    Support support;
    Meta meta;

    UserModel({
        required this.page,
        required this.perPage,
        required this.total,
        required this.totalPages,
        required this.data,
        required this.support,
        required this.meta,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        support: Support.fromJson(json["support"]),
        meta: Meta.fromJson(json["_meta"]),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "support": support.toJson(),
        "_meta": meta.toJson(),
    };
}

class Datum {
    int id;
    String email;
    String firstName;
    String lastName;
    String avatar;

    Datum({
        required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.avatar,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
    };
}

class Meta {
    String poweredBy;
    String docsUrl;
    String upgradeUrl;
    String exampleUrl;
    String variant;
    String message;
    Cta cta;
    String context;

    Meta({
        required this.poweredBy,
        required this.docsUrl,
        required this.upgradeUrl,
        required this.exampleUrl,
        required this.variant,
        required this.message,
        required this.cta,
        required this.context,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        poweredBy: json["powered_by"],
        docsUrl: json["docs_url"],
        upgradeUrl: json["upgrade_url"],
        exampleUrl: json["example_url"],
        variant: json["variant"],
        message: json["message"],
        cta: Cta.fromJson(json["cta"]),
        context: json["context"],
    );

    Map<String, dynamic> toJson() => {
        "powered_by": poweredBy,
        "docs_url": docsUrl,
        "upgrade_url": upgradeUrl,
        "example_url": exampleUrl,
        "variant": variant,
        "message": message,
        "cta": cta.toJson(),
        "context": context,
    };
}

class Cta {
    String label;
    String url;

    Cta({
        required this.label,
        required this.url,
    });

    factory Cta.fromJson(Map<String, dynamic> json) => Cta(
        label: json["label"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "url": url,
    };
}

class Support {
    String url;
    String text;

    Support({
        required this.url,
        required this.text,
    });

    factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
    };
}
