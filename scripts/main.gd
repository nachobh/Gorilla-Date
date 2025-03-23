extends "res://scripts/input_map.gd"

@onready var game_manager = $GameManager
@onready var camera = $Camera2D
@onready var background = $Background
@onready var reset_button = $UI/ResetButton

func _ready():
	camera.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	
	background.texture = preload("res://assets/sprites/background.png")
	background.scale = Vector2(
		get_viewport_rect().size.x / background.texture.get_width(),
		get_viewport_rect().size.y / background.texture.get_height()
	)
	
	reset_button.pressed.connect(_on_reset_button_pressed)
	
	game_manager.connect("projectile_launched", Callable(self, "_on_projectile_launched"))
	
	setup_input_mappings()

func _process(delta):
	if Input.is_action_just_pressed("reset_game"):
		reset_game()

func _on_reset_button_pressed():
	reset_game()

func reset_game():
	game_manager.reset_game()
	
	camera.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)

func _on_projectile_launched(emoji, position, angle, power):
	var projectile_manager = $ProjectileManager
	if projectile_manager.active_projectiles.size() > 0:
		camera.global_position = projectile_manager.active_projectiles[0].global_position
