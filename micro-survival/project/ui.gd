class_name UICanvas
extends CanvasLayer

@onready var thirst_bar: ProgressBar = %ThirstBar
@onready var health_bar: ProgressBar = %HealthBar
@onready var start_button: Button = %StartButton
@onready var game_over_container: VBoxContainer = %GameOverContainer




func _ready() -> void:
  game_over_container.visible = false
  start_button.pressed.connect(_on_start_pressed)

func _on_start_pressed():
  get_tree().paused = false
  get_tree().reload_current_scene()
