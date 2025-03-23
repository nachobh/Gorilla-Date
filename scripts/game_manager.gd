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

var path_clead: bool = false
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
	print(new_state)
	current_state = new_state
