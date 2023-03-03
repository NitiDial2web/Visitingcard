///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class getCategoryImageDataList {
/*
{
  "id": 1,
  "name": "Art_Design",
  "image": "https://visitmysite.in/visitingcard/public/uploads/resume_image/v_card1.png",
  "filename": "v_card1"
}
*/

  int? id;
  String? name;
  String? image;
  String? filename;

  getCategoryImageDataList({
    this.id,
    this.name,
    this.image,
    this.filename,
  });
  getCategoryImageDataList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    image = json['image']?.toString();
    filename = json['filename']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['filename'] = filename;
    return data;
  }
}

class getCategoryImageData {
/*
{
  "category_name": "Art & Design",
  "list": [
    {
      "id": 1,
      "name": "Art_Design",
      "image": "https://visitmysite.in/visitingcard/public/uploads/resume_image/v_card1.png",
      "filename": "v_card1"
    }
  ]
}
*/

  String? categoryName;
  List<getCategoryImageDataList?>? list;

  getCategoryImageData({
    this.categoryName,
    this.list,
  });
  getCategoryImageData.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name']?.toString();
    if (json['list'] != null) {
      final v = json['list'];
      final arr0 = <getCategoryImageDataList>[];
      v.forEach((v) {
        arr0.add(getCategoryImageDataList.fromJson(v));
      });
      list = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['category_name'] = categoryName;
    if (list != null) {
      final v = list;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['list'] = arr0;
    }
    return data;
  }
}

class getCategoryImage {
/*
{
  "success": 1,
  "data": [
    {
      "category_name": "Art & Design",
      "list": [
        {
          "id": 1,
          "name": "Art_Design",
          "image": "https://visitmysite.in/visitingcard/public/uploads/resume_image/v_card1.png",
          "filename": "v_card1"
        }
      ]
    }
  ],
  "msg": "Category data is found successfully"
}
*/

  int? success;
  List<getCategoryImageData?>? data;
  String? msg;

  getCategoryImage({
    this.success,
    this.data,
    this.msg,
  });
  getCategoryImage.fromJson(Map<String, dynamic> json) {
    success = json['success']?.toInt();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <getCategoryImageData>[];
      v.forEach((v) {
        arr0.add(getCategoryImageData.fromJson(v));
      });
      this.data = arr0;
    }
    msg = json['msg']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    data['msg'] = msg;
    return data;
  }
}
