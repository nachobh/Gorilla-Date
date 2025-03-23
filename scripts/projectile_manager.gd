extends Node2D

var projectile_scene = preload("res://scenes/projectile.tscn")
var active_projectiles = []

@onready var game_manager = get_node("../GameManager")

func _ready():
	game_manager.connect("projectile_launched", Callable(self, "launch_projectile"))

func launch_projectile(emoji, position, angle, power):
	var projectile = projectile_scene.instantiate()
	
	var player_num = 1 if game_manager.current_state == game_manager.GameState.PLAYER1_TURN else 2
	
	projectile.setup(emoji, position, angle, power, player_num, self)
	
	add_child(projectile)
	
	active_projectiles.append(projectile)

func on_projectile_landed(projectile):
	active_projectiles.erase(projectile)
	
	if active_projectiles.size() == 0:
		game_manager.on_projectile_landed()

func _process(delta):
	for projectile in active_projectiles.duplicate():
		if projectile.global_position.y > 1000 or projectile.global_position.x < -100 or projectile.global_position.x > 1100:
			active_projectiles.erase(projectile)
			projectile.queue_free()
			
			if active_projectiles.size() == 0:
				game_manager.on_projectile_landed()
