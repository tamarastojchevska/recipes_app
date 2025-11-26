class Recipe {
  String id;
  String name;
  String image;
  String instructions;
  String ingredients;
  String youtube;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
    required this.ingredients,
    required this.youtube,
  });

  Recipe.fromJson(Map<String, dynamic> data)
    : id = data['idMeal'],
      name = data['strMeal'],
      image = data['strMealThumb'],
      instructions = data['strInstructions'],
      ingredients = _getIngredients(data),
      youtube = data['strYoutube'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'instructions': instructions,
    'ingredients': ingredients,
    'youtube': youtube,
  };

  static String _getIngredients(Map<String, dynamic> data) {
    String temp = "";
    for (var i = 1; i < 21; i++) {
      if (data['ingredient$i'] != null || data['strMeasure$i'] != null) {
        temp += '${data['strIngredient$i']} ${data['strMeasure$i']},';
      }
    }
    return temp;
  }
}
