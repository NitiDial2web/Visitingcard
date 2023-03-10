class GetCategoryImageDataList {
  GetCategoryImageDataList({
    required this.success,
    required this.data,
    required this.msg,
  });
  late final int success;
  late final List<Data> data;
  late final String msg;

  GetCategoryImageDataList.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['msg'] = msg;
    return _data;
  }
}

class Data {
  Data({
    required this.categoryName,
    required this.list,
  });
  late final String categoryName;
  late final List<List1> list;

  // Data.fromJson(Map<String, dynamic> json){
  //   categoryName = json['category_name'];
  //   list = List<List>.from(json['list']).map((e)=>List.fromJson(e)).toList();
  // }

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryName: json["category_name"],
    list: List<List1>.from(json["list"].map((x) => List1.fromJson(x))),
  );

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['category_name'] = categoryName;
  //   _data['list'] = list.map((e)=>e.toJson()).toList();
  //   return _data;
  // }
  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "list": List<List1>.from(list.map((x) => x.toJson())),
  };
}

class List1 {
  List1({
    required this.id,
    required this.name,
    required this.image,
    required this.filename,
  });
  late final int id;
  late final String name;
  late final String image;
  late final String filename;

  // List.fromJson(Map<String, dynamic> json){
  //   id = json['id'];
  //   name = json['name'];
  //   image = json['image'];
  //   filename = json['filename'];
  // }
  factory List1.fromJson(Map<String, dynamic> json) => List1(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    filename: json["filename"],
  );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['filename'] = filename;
    return _data;
  }
}