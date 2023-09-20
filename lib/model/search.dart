// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  List<Mail>? mails;

  SearchModel({
    this.mails,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    mails: json["mails"] == null ? [] : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mails": mails == null ? [] : List<dynamic>.from(mails!.map((x) => x.toJson())),
  };
}

class Mail {
  int? id;
  String? subject;
  String? description;
  String? senderId;
  String? archiveNumber;
  DateTime? archiveDate;
  String? decision;
  String? statusId;
  dynamic finalDecision;
  DateTime? createdAt;
  DateTime? updatedAt;
  Sender? sender;
  Status? status;
  List<dynamic>? attachments;
  List<Activity>? activities;
  List<Status>? tags;

  Mail({
    this.id,
    this.subject,
    this.description,
    this.senderId,
    this.archiveNumber,
    this.archiveDate,
    this.decision,
    this.statusId,
    this.finalDecision,
    this.createdAt,
    this.updatedAt,
    this.sender,
    this.status,
    this.attachments,
    this.activities,
    this.tags,
  });

  factory Mail.fromJson(Map<String, dynamic> json) => Mail(
    id: json["id"],
    subject: json["subject"],
    description: json["description"],
    senderId: json["sender_id"],
    archiveNumber: json["archive_number"],
    archiveDate: json["archive_date"] == null ? null : DateTime.parse(json["archive_date"]),
    decision: json["decision"],
    statusId: json["status_id"],
    finalDecision: json["final_decision"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    attachments: json["attachments"] == null ? [] : List<dynamic>.from(json["attachments"]!.map((x) => x)),
    activities: json["activities"] == null ? [] : List<Activity>.from(json["activities"]!.map((x) => Activity.fromJson(x))),
    tags: json["tags"] == null ? [] : List<Status>.from(json["tags"]!.map((x) => Status.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "description": description,
    "sender_id": senderId,
    "archive_number": archiveNumber,
    "archive_date": archiveDate?.toIso8601String(),
    "decision": decision,
    "status_id": statusId,
    "final_decision": finalDecision,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "sender": sender?.toJson(),
    "status": status?.toJson(),
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x)),
    "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
  };
}

class Activity {
  int? id;
  Body? body;
  String? userId;
  String? mailId;
  dynamic sendNumber;
  dynamic sendDate;
  dynamic sendDestination;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  Activity({
    this.id,
    this.body,
    this.userId,
    this.mailId,
    this.sendNumber,
    this.sendDate,
    this.sendDestination,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json["id"],
    body: bodyValues.map[json["body"]]!,
    userId: json["user_id"],
    mailId: json["mail_id"],
    sendNumber: json["send_number"],
    sendDate: json["send_date"],
    sendDestination: json["send_destination"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": bodyValues.reverse[body],
    "user_id": userId,
    "mail_id": mailId,
    "send_number": sendNumber,
    "send_date": sendDate,
    "send_destination": sendDestination,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

enum Body {
  ANY_TEXT,
  EMPTY,
  NEW_ACTIVITY,
  OK,
  OKK
}

final bodyValues = EnumValues({
  "any text": Body.ANY_TEXT,
  "": Body.EMPTY,
  "new activity": Body.NEW_ACTIVITY,
  "ok": Body.OK,
  "okk": Body.OKK
});

class User {
  int? id;
  UserName? name;
  Email? email;
  Image? image;
  dynamic emailVerifiedAt;
  String? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Status? role;

  User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.emailVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: userNameValues.map[json["name"]]!,
    email: emailValues.map[json["email"]]!,
    image: imageValues.map[json["image"]]!,
    emailVerifiedAt: json["email_verified_at"],
    roleId: json["role_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    role: json["role"] == null ? null : Status.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": userNameValues.reverse[name],
    "email": emailValues.reverse[email],
    "image": imageValues.reverse[image],
    "email_verified_at": emailVerifiedAt,
    "role_id": roleId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "role": role?.toJson(),
  };
}

enum Email {
  A_A_COM,
  ENAS_GMAIL_COM
}

final emailValues = EnumValues({
  "a@a.com": Email.A_A_COM,
  "enas@gmail.com": Email.ENAS_GMAIL_COM
});

enum Image {
  PROFILES_P8_QM0_C_NI6_ZVGOU_NX_OO8_K_PPL_XR_O8_Q8_EE_VDLX77_BO_F_PNG,
  PROFILES_ZJ_WNWLM3_PA8_ZQOBJP_EN_WY7_Z2_Q_Y_SGFY1_FJE_Z_WGB7_W_JPG
}

final imageValues = EnumValues({
  "profiles/p8Qm0cNI6ZVGOUNxOO8kPplXrO8Q8EeVDLX77BoF.png": Image.PROFILES_P8_QM0_C_NI6_ZVGOU_NX_OO8_K_PPL_XR_O8_Q8_EE_VDLX77_BO_F_PNG,
  "profiles/ZjWNWLM3PA8zqobjpEnWy7Z2qYSgfy1FjeZWgb7W.jpg": Image.PROFILES_ZJ_WNWLM3_PA8_ZQOBJP_EN_WY7_Z2_Q_Y_SGFY1_FJE_Z_WGB7_W_JPG
});

enum UserName {
  ENAS,
  OSAMA_AHMED
}

final userNameValues = EnumValues({
  "enas": UserName.ENAS,
  "osama ahmed": UserName.OSAMA_AHMED
});

class Status {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  Color? color;
  Pivot? pivot;

  Status({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.pivot,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    color: colorValues.map[json["color"]]!,
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "color": colorValues.reverse[color],
    "pivot": pivot?.toJson(),
  };
}

enum Color {
  THE_0_XFFFA3_A57,
  THE_0_XFFFFE120
}

final colorValues = EnumValues({
  "0xfffa3a57": Color.THE_0_XFFFA3_A57,
  "0xffffe120": Color.THE_0_XFFFFE120
});

class Pivot {
  String? mailId;
  String? tagId;

  Pivot({
    this.mailId,
    this.tagId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    mailId: json["mail_id"],
    tagId: json["tag_id"],
  );

  Map<String, dynamic> toJson() => {
    "mail_id": mailId,
    "tag_id": tagId,
  };
}

class Sender {
  int? id;
  SenderName? name;
  String? mobile;
  dynamic address;
  String? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Status? category;

  Sender({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    name: senderNameValues.map[json["name"]]!,
    mobile: json["mobile"],
    address: json["address"],
    categoryId: json["category_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    category: json["category"] == null ? null : Status.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": senderNameValues.reverse[name],
    "mobile": mobile,
    "address": address,
    "category_id": categoryId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "category": category?.toJson(),
  };
}

enum SenderName {
  AHMED,
  HELLO,
  RGS
}

final senderNameValues = EnumValues({
  "ahmed": SenderName.AHMED,
  "hello": SenderName.HELLO,
  "RGS": SenderName.RGS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
