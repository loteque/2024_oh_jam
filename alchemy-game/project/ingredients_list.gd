@tool
extends HFlowContainer

@export var ingredients: Array[Ingredient]

func _enter_tree() -> void:
  for ingredient: Ingredient in ingredients:
    var ingredient_node: IngredientNode = IngredientNode.new(ingredient)
    add_child(ingredient_node)
