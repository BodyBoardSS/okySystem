import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());


class Category {
  
    int? id;
    String? name;
    String? description;

    Category({
        this.id,
        this.name,
        this.description,
    });


    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

    static List<Category> fromJsonList(List<dynamic> jsonList){
      List<Category> list = [];
      for (var item in jsonList) {
        Category category = Category.fromJson(item);
        list.add(category);
      }

      return list;
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}
