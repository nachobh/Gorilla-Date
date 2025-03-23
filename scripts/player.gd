extends CharacterBody2D

@export var player_number: int = 1
@export var player_color: Color = Color.BLUE

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

var is_my_turn: bool = false
var health: int = 100

func _ready():
	if player_number == 1:
		player_color = Color.BLUE
	else:
		player_color = Color.RED
		sprite.flip_h = true
	
	sprite.modulate = player_color
	
	var game_manager = get_node("../GameManager")
	game_manager.connect("turn_changed", Callable(self, "_on_turn_changed"))
	game_manager.connect("game_over", Callable(self, "_on_game_over"))

func _on_turn_changed(player_num):
	is_my_turn = (player_num == player_number)
	
	if is_my_turn:
		animation_player.play("highlight")
	else:
		animation_player.play("idle")

func _on_game_over(winner):
	if winner == player_number:
		animation_player.play("victory")
	else:
		animation_player.play("defeat")

func take_damage(amount):
	health -= amount
	
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = player_color
	
	if health <= 0:
		die()

func die():
	animation_player.play("defeat")
	
	var game_manager = get_node("../GameManager")
	var winner = 2 if player_number == 1 else 1
	game_manager.winner = winner
	game_manager.change_state(game_manager.GameState.GAME_OVER)
