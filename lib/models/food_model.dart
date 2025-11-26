class Food {
  String id;
  String name;
  String image;

  Food({required this.id, required this.name, required this.image});

  Food.fromJson(Map<String, dynamic> data)
    : id = data['idMeal'],
      name = data['strMeal'],
      image = data['strMealThumb'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image
  };
}
