@tool
class_name IngredientNode
extends ColorRect

var ingredient: Ingredient
var label: Label = Label.new()

func _init(init_ingredient: Ingredient) -> void:
  ingredient = init_ingredient
  custom_minimum_size = Vector2(50, 50)
  color = ingredient.color
  #size_flags_horizontal = Control.SIZE_EXPAND_FILL
  #size_flags_vertical = Control.SIZE_EXPAND_FILL

  mouse_filter = Control.MOUSE_FILTER_STOP
  label.text = ingredient.name
  add_child(label)
    
func _ready() -> void:
  #add_child(label)
  pass

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
  return true

func _get_drag_data(at_position: Vector2) -> Variant:
  return self

func _drop_data(at_position: Vector2, data: Variant) -> void:
  # for all recipes:
  var comined_ingredients = [ingredient, data.ingredient]
  comined_ingredients.sort_custom(func(a, b): return a.name < b.name)
  for recipe: Ingredient in Ingredient.recipes:
    var ingredient_names = comined_ingredients.map(func(ingredient): return ingredient.name)
    print("comined_ingredients: ", ingredient_names, "current recipe: ", recipe.name)
    var current_ingredient_names = recipe.ingredients.map(func(ingredient): return ingredient.name)
    print("current recipe ingredients: ", current_ingredient_names)
    if comined_ingredients == recipe.ingredients:
      add_sibling(IngredientNode.new(recipe))
      data.queue_free.call_deferred()
      queue_free.call_deferred()
      
      
    
  # if recipe
