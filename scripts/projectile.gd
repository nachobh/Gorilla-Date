extends RigidBody2D

var emoji: String = "🍌"
var explosion_type: String = "banana_explosion"
var damage: int = 1
var shooter_player: int = 1 

@onready var label = $Label
@onready var trail = $Trail

var initial_velocity: Vector2
var gravity_scale_value: float = 1.0

var projectile_manager

func _ready():
	label.text = emoji
	gravity_scale = gravity_scale_value
	trail.emitting = true
	
	body_entered.connect(_on_body_entered)
	
	var timer = Timer.new()
	timer.wait_time = 10.0
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.start()

func setup(emoji_str, pos, angle_deg, power, player_num, manager):
	emoji = emoji_str
	shooter_player = player_num
	projectile_manager = manager
	
	global_position = pos
	
	var angle_rad = deg_to_rad(angle_deg)
	var velocity_x = cos(angle_rad) * power
	var velocity_y = -sin(angle_rad) * power
	initial_velocity = Vector2(velocity_x, velocity_y)
	
	match emoji:
		"🍌":
			damage = 1
			explosion_type = "banana_explosion"
		"💣":
			damage = 3
			explosion_type = "bomb_explosion"
		"🍎":
			damage = 1
			explosion_type = "apple_explosion"
		"🔥":
			damage = 2
			explosion_type = "fire_explosion"
		"💩":
			damage = 1
			explosion_type = "poop_explosion"
		"🚀":
			damage = 3
			explosion_type = "rocket_explosion"
			gravity_scale_value = 0.5 
		"⚽":
			damage = 1
			explosion_type = "ball_explosion"
			gravity_scale_value = 1.2 
		"🎱":
			damage = 2
			explosion_type = "eight_ball_explosion"
			gravity_scale_value = 1.5 
	
	gravity_scale = gravity_scale_value

func _integrate_forces(state):
	if state.get_step() == 1:
		state.linear_velocity = initial_velocity

func _on_body_entered(body):
	if body is StaticBody2D:
		body.take_damage(damage, explosion_type)
		explode()
	elif body is CharacterBody2D:
		var player_script = body as CharacterBody2D
		
		if player_script.player_number != shooter_player:
			player_script.take_damage(damage * 10)
			explode()

func explode():
	var explosion_scene = load("res://scenes/explosions/" + explosion_type + ".tscn")
	if explosion_scene:
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		get_tree().current_scene.add_child(explosion)
	
	if projectile_manager:
		projectile_manager.on_projectile_landed(self)
	
	queue_free()

func _on_timeout():
	if projectile_manager:
		projectile_manager.on_projectile_landed(self)
	queue_free()
