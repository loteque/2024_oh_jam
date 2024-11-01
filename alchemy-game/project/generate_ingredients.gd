extends Node



func _ready() -> void:
  var ingredient = Ingredient.new()
  ingredient.name = "SAMPLE"
  #ingredient.ingredients
  ingredient.color = Color(1, 1, 1)
  var err = ResourceSaver.save(ingredient, "res://test_ingredients/" + ingredient.name + ".tres")
  print(err)

func create_permutations() -> Array[Array]:
  # get all ingredients from: res://ingredient/resources
  # save them as var ingredients: Array[Ingredient]

  # Create a starting index for ingredient pairs.
  # For each ingredient:
  # var pairs_for_this_ingredient
  #for ingre
  # pair it will all other ingredients that is hasn't been paired with yet including itself.
  # incriment the pairing index by 1.
  
  
  return []
  pass

func get_ingredient_by_name(ingredient_name: String):
  pass
