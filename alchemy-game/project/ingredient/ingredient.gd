class_name Ingredient
extends Resource

@export var name: String = ""
@export var ingredients: Array[Ingredient]
@export var color: Color = Color(1, 1, 1)
@export var order: int = 0

static var recipes: Dictionary[Ingredient, bool]

func _init():
  ingredients.sort_custom(func(a, b): return a.name < b.name)
  recipes[self] = true
