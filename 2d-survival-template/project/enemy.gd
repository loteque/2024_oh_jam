extends StaticBody2D

@onready var player: CharacterBody2D = %Player
@export var speed: int = 80

func _physics_process(delta: float) -> void:
  var direction = global_position.direction_to(player.global_position)
  var velocity = direction * speed
  var translation = velocity * delta
  position = position + translation
