extends StaticBody2D

#var player: Node2D
@onready var player: CharacterBody2D = %Player

@export var speed: int = 80

@export var chase_distance: float = 20.0

var attack_interval: float = 0.5
var is_touching_player := false

func _ready() -> void:
  player

func _physics_process(delta: float) -> void:
  if not player.is_hidden:
    var direction = global_position.direction_to(player.global_position)
    var velocity = direction * speed
    var translation = velocity * delta
    position = position + translation
