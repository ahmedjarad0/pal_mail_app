class TagCreate {
  String? message;
  Tag? tag;

  TagCreate({this.message, this.tag});

  TagCreate.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    tag = json['tag'] != null ? new Tag.fromJson(json['tag']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.tag != null) {
      data['tag'] = this.tag!.toJson();
    }
    return data;
  }
}

class Tag {
  String? name;
  String? updatedAt;
  String? createdAt;
  int? id;

  Tag({this.name, this.updatedAt, this.createdAt, this.id});

  Tag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}