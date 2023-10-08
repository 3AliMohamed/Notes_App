class Notes {
  bool? status;
  List<Note>? data;
  String? message;

  Notes({this.status, this.data, this.message});

  Notes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Note>[];
      json['data'].forEach((v) {
        data!.add(Note.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Note {
  int? id;
  int? userId;
  String? content;
  String? createdAt;
  String? updatedAt;

  Note({this.id, this.userId, this.content, this.createdAt, this.updatedAt});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}