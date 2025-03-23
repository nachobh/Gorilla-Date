extends Node2D

@export var path_width: int = 600
@export var path_height: int = 100
@export var obstacle_count: int = 10
@export var min_obstacle_size: Vector2 = Vector2(20, 20)
@export var max_obstacle_size: Vector2 = Vector2(80, 80)

var obstacle_scene = preload("res://scenes/obstacle.tscn")
var path_node: Node2D

var obstacle_types = {
	"brick": {"health": 3, "texture": "res://assets/sprites/obstacles/brick.png"},
	"wood": {"health": 2, "texture": "res://assets/sprites/obstacles/wood.png"},
	"glass": {"health": 1, "texture": "res://assets/sprites/obstacles/glass.png"}
}

func _ready():
	path_node = get_node("../Path")
	
	generate_path()
	
	position_players()

func generate_path():
	for child in path_node.get_children():
		child.queue_free()
	
	for i in range(obstacle_count):
		create_random_obstacle(i)

func create_random_obstacle(index):
	var obstacle = obstacle_scene.instantiate()
	
	var x_position = (path_width / (obstacle_count + 1)) * (index + 1)
	var y_position = randf_range(0, path_height)
	
	var obstacle_type = obstacle_types.keys()[randi() % obstacle_types.size()]
	var properties = obstacle_types[obstacle_type]
	
	obstacle.position = Vector2(x_position, y_position)
	obstacle.health = properties["health"]
	obstacle.texture_path = properties["texture"]
	
	var size_x = randf_range(min_obstacle_size.x, max_obstacle_size.x)
	var size_y = randf_range(min_obstacle_size.y, max_obstacle_size.y)
	obstacle.size = Vector2(size_x, size_y)
	
	path_node.add_child(obstacle)

func position_players():
	var player1 = get_node("../Player1")
	var player2 = get_node("../Player2")
	
	player1.position = Vector2(50, 50)
	
	player2.position = Vector2(path_width + 100, 50)

func is_path_cleared():
	return path_node.get_child_count() == 0
