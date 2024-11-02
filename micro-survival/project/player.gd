extends CharacterBody2D

@export var speed = 100
@export var max_health: int = 100
@export var max_thirst: int = 100

@export var thirst_tick_amount: int = 1
@export var thirst_interval: float = 2

@onready var ui: UICanvas = %UI
@onready var detector: Area2D = %Detector
@onready var game_over_container: VBoxContainer = %GameOverContainer



var is_in_bush := false
var is_dead := false


var tick_damage_interval: float = 0.5
var thirst_tick_interval: float = 0.5

var is_hidden: bool:
  get: return is_in_bush

var current_thirst = max_thirst:
  set(val):
    var new_thirst = val
    current_thirst = max(0, new_thirst)
    ui.thirst_bar.value = current_thirst
    if current_thirst == 0:
      take_damage(10)
    
    
var current_health = max_health:
  set(val):
    current_health = val
    ui.health_bar.value = current_health
    if current_health == 0 and not is_dead:
      die()

var thirst_timer: Timer = Timer.new()
var damage_timer: Timer = Timer.new()


var can_drink_water := false



func _ready() -> void:
  add_child(thirst_timer)
  add_child(damage_timer)
  thirst_timer.timeout.connect(_on_thirst_timeout)
  damage_timer.timeout.connect(_on_damage_timeout)
  thirst_timer.start(thirst_tick_interval)
  
  
  
  ui.thirst_bar.max_value = max_thirst
  ui.thirst_bar.value = current_thirst
  
  ui.health_bar.max_value = max_health
  ui.health_bar.value = current_health

func _on_thirst_timeout():
  tick_thirst()

func _on_damage_timeout():
  take_damage(10)

func _input(event: InputEvent) -> void:
  if can_drink_water:
    if Input.is_action_just_pressed("interact"):
      drink_water()

func drink_water():
  current_thirst += 2

func _physics_process(delta: float) -> void:
  var input = Input.get_vector("left", "right", "up", "down").normalized()
  velocity = speed * input
  move_and_slide()

func tick_thirst():
  current_thirst -= thirst_tick_amount


func die():
  is_dead = true
  game_over_container.visible = true
  get_tree().paused = true

func take_damage(amount: int):
  var new_health = current_health - amount 
  current_health = max(0, new_health)
  

func _on_detector_area_entered(area: Area2D) -> void:
  if area.is_in_group("Bush"):
    is_in_bush = true

func _on_detector_area_exited(area: Area2D) -> void:
  if area.is_in_group("Bush"):
    is_in_bush = false

func _on_detector_body_entered(body: Node2D) -> void:
  if body.is_in_group("Enemy"):
    damage_timer.start(tick_damage_interval)

func _on_detector_body_exited(body: Node2D) -> void:
  if body.is_in_group("Enemy"):
    damage_timer.stop()
