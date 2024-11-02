extends Area2D

func _on_body_entered(body: Node2D) -> void:
  if body.is_in_group("Player"):
    body.can_drink_water = true
    
func _on_body_exited(body: Node2D) -> void:
  if body.is_in_group("Player"):
    body.can_drink_water = false
