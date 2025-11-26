class Category {
  String id;
  String name;
  String image;
  String description;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  Category.fromJson(Map<String, dynamic> data)
    : id = data['idCategory'],
      name = data['strCategory'],
      image = data['strCategoryThumb'],
      description = data['strCategoryDescription'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'description': description,
  };
}
