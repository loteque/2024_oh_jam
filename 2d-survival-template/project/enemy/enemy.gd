extends StaticBody2D

@export var player: CharacterBody2D
@export var speed: int = 80

func _physics_process(delta: float) -> void:
  var direction = global_position.direction_to(player.global_position)
  var velocity = direction * speed
  var translation = velocity * delta
  position = position + translation
