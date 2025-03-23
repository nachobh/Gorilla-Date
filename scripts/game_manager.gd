extends Node

enum GameState {SETUP, PLAYER1_TURN, PLAYER2_TURN, PROJECTILE_MOVING, GAME_OVER}
var current_state: int = GameState.SETUP

var player1: CharacterBody2D
var player2: CharacterBody2D
var current_player: CharacterBody2D

var selected_emoji: String = "🍌"
var emoji_list: Array = ["🍌", "💣", "🍎", "🔥", "💩", "🚀", "⚽", "🎱"]
var explosion_types: Dictionary = {
	"🍌": "banana_explosion",
	"💣": "bomb_explosion",
	"🍎": "apple_explosion",
	"🔥": "fire_explosion",
	"💩": "poop_explosion",
	"🚀": "rocket_explosion",
	"⚽": "ball_explosion",
	"🎱": "eight_ball_explosion"
}

var angle: float = 45.0
var power: float = 50.0
var max_power: float = 100.0

var path_cleared: bool = false
var winner: int = 0

signal turn_changed(player_num)

func _ready():
	player1 = get_node("../Player1")
	player2 = get_node("../Player2")
	await get_tree().create_timer(0.5).timeout
	start_game()

func start_game():
	change_state(GameState.PLAYER1_TURN)
	
func change_state(new_state: int):
	current_state = new_state
	match current_state:
		GameState.PLAYER1_TURN:
			current_player = player1
			emit_signal("turn_changed", 1)
		GameState.PLAYER2_TURN:
			current_player = player2
			emit_signal("turn_changed", 2)
		GameState.PROJECTILE_MOVING:
			pass
		GameState.GAME_OVER:
			emit_signal("game_over", winner)
func _process(delta):
	if current_state == GameState.PLAYER1_TURN or current_state == GameState.PLAYER2_TURN:
		process_player_input()

func process_player_input():
	if Input.is_action_pressed("angle_up"):
		angle = min(angle + 1, 90)
	elif Input.is_action_pressed("angle_down"):
		angle = max(angle - 1, 0)
	if Input.is_action_pressed("power_up"):
		power = min(power + 1, max_power)
	elif Input.is_action_pressed("power_down"):
		power = max(power - 1, 10)
	if Input.is_action_just_pressed("launch"):
		launch_projectile()
	if Input.is_action_just_pressed("next_emoji"):
		cycle_emoji(1)
	elif Input.is_action_just_pressed("prev_emoji"):
		cycle_emoji(-1)

func cycle_emoji(direction: int):
	var current_index = emoji_list.find(selected_emoji)
	var new_index = (current_index + direction) % emoji_list.size()
	if new_index < 0:
		new_index = emoji_list.size() - 1
	
	selected_emoji = emoji_list[new_index]
	emit_signal("emoji_selected", selected_emoji)

func launch_projectile():
	var launch_position = current_player.get_node("LaunchPoint").global_position
	var direction = 1 if current_state == GameState.PLAYER1_TURN else -1
	var adjusted_angle = angle if direction > 0 else 180 - angle
	emit_signal("projectile_launched", selected_emoji, launch_position, adjusted_angle, power)
	change_state(GameState.PROJECTILE_MOVING)

func on_projectile_landed():
	check_path_status()
	if current_state != GameState.GAME_OVER:
		var next_state = GameState.PLAYER2_TURN if current_state == GameState.PROJECTILE_MOVING and current_player == player1 else GameState.PLAYER1_TURN
		change_state(next_state)

func check_path_status():
	var path_node = get_node("../Path")
	var obstacles = path_node.get_children()
	if obstacles.size() == 0:
		path_cleared = true
	if path_cleared:
		winner = 1 if current_player == player1 else 2
		change_state(GameState.GAME_OVER)

func reset_game():
	path_cleared = false
	winner = 0
	angle = 45.0
	power = 50.0
	selected_emoji = "🍌"
	
	change_state(GameState.SETUP)
	await get_tree().create_timer(0.5).timeout
	start_game()
