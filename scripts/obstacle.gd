extends StaticBody2D

@export var health: int = 3
@export var texture_path: String = "res://assets/sprites/obstacles/brick.png"
@export var size: Vector2 = Vector2(50, 50)

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@onready var animation_player = $AnimationPlayer

func _ready():
	var texture = load(texture_path)
	if texture:
		sprite.texture = texture
	
	sprite.scale = size / sprite.texture.get_size()
	
	var shape = RectangleShape2D.new()
	shape.size = size
	collision_shape.shape = shape

func take_damage(amount, explosion_type):
	health -= amount	
	animation_player.play("hit")
	show_explosion(explosion_type)
	
	if health <= 0:
		destroy()

func show_explosion(explosion_type):
	var explosion_scene = load("res://scenes/explosions/" + explosion_type + ".tscn")
	if explosion_scene:
		var explosion = explosion_scene.instantiate()
		explosion.position = Vector2.ZERO
		add_child(explosion)

func destroy():
	animation_player.play("destroy")
	
	await animation_player.animation_finished
	queue_free()
