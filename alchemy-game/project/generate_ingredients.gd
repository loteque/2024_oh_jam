class_name IngredientUtil
extends Node

func save_ingredients(ingredients: Array[Ingredient], path: String):
  for ingredient in ingredients:
    ResourceSaver.save(ingredient, path + ingredient.name + ".tres")

func _ready() -> void:
  var ingredients: Array[Ingredient] = get_ingredients()
  var permutations: Array[Array] = create_permutations(ingredients)
  var new_ingredients = create_ingredients_from_permutations(permutations)
  for ingredient in new_ingredients:
    print(ingredient.name)
    print(ingredient.ingredients)
  var path: String = "res://test_ingredients/"
  save_ingredients(new_ingredients, path)
  #var ingredient = Ingredient.new()
  #ingredient.name = "SAMPLE"
  ##ingredient.ingredients
  #ingredient.color = Color(1, 1, 1)
  #var err = ResourceSaver.save(ingredient, "res://test_ingredients/" + ingredient.name + ".tres")
  #print(err)

#func create_permutations() -> Array[Array]:
  # get all ingredients from: res://ingredient/resources
  # save them as var ingredients: Array[Ingredient]

static func get_ingredients() -> Array[Ingredient]:
  var ingredients: Array[Ingredient] = []
  var path = "res://ingredient/resources"
  #path = "res://test_ingredients/"
  var dir: DirAccess = DirAccess.open(path)
  if dir:
    dir.list_dir_begin()
    while true:
      var file: String = dir.get_next()
      if file == "":
          break  # No more files to process

      # Check if the file has a .tres extension
      if file.ends_with(".tres"):
          var full_path: String = path + "/" + file

          # Load the resource from the file path
          var resource: Resource = ResourceLoader.load(full_path)

          # Ensure the resource is valid and is of type Ingredient
          if resource and resource is Ingredient:
              ingredients.append(resource)
          else:
              push_error("Failed to load Ingredient from: " + full_path)
    # End the directory listing
    dir.list_dir_end()
  else:
      push_error("Failed to open directory: " + path)
  #print(ingredients.map(func(ing): return ing.name))
  ingredients.sort_custom(func(a, b): return a.name < b.name)
  return ingredients

func calculate_new_order(ingredient_a: Ingredient, ingredient_b: Ingredient):
  return max(ingredient_a.order, ingredient_b.order) + 1

func array_in_list(arr: Array, list: Array[Array]):
  return list.any(func(pair): return arr == pair)

func print_pairs(pairs: Array[Array]):
  for pair: Array[Ingredient] in pairs:
    if pair.size() < 2: continue
    print(pair[0].name, " ", pair[1].name)

func create_permutations(ingredients: Array[Ingredient]) -> Array[Array]:
    var permutations: Array[Array] = []
    var existing_pairs: Array[Array] = []
    var ingredient_pairs = ingredients.map(func(ingredient): return ingredient.ingredients)
    existing_pairs.append_array(ingredient_pairs)
    #print_pairs(existing_pairs)
    # Iterate through each ingredient using its index
    for i in range(ingredients.size()):
        var current_ingredient = ingredients[i]
        
        # Pair the current ingredient with itself and all subsequent ingredients
        for j in range(i, ingredients.size()):
            var paired_ingredient = ingredients[j]
            var new_pair = [current_ingredient, paired_ingredient]
            var already_exists = array_in_list(new_pair, existing_pairs)
            #print(already_exists)
            if not already_exists:
              permutations.append(new_pair)
            # Optional: If you need to keep track of pair indices, you can store (i, j) instead
            # permutations.append([i, j])
            
              #print([current_ingredient.name, paired_ingredient.name])
              #print("Current orders: ", current_ingredient.order, " ", paired_ingredient.order, ", new order: ", new_order)
    
    return permutations

func create_ingredients_from_permutations(permutations: Array[Array]) -> Array[Ingredient]:
  var ingredients: Array[Ingredient] = []
  for pair: Array[Ingredient] in permutations:
    var ingredient_a = pair[0]
    var ingredient_b = pair[1]
    var new_ingredient = Ingredient.new()
    new_ingredient.order = calculate_new_order(ingredient_a, ingredient_b)
    new_ingredient.name  = ingredient_a.name + ingredient_b.name
    new_ingredient.ingredients = [ingredient_a, ingredient_b] as Array[Ingredient]
    new_ingredient.color = generate_color(ingredient_a.color, ingredient_b.color)
    ingredients.append(new_ingredient)
      
  return ingredients
  
func generate_color(color_a: Color, color_b: Color) -> Color:
  if color_a == color_b:
    return color_a.darkened(0.15)
  return color_a.lerp(color_b, 0.5)
  

func get_ingredient_by_name(ingredient_name: String):
  pass
