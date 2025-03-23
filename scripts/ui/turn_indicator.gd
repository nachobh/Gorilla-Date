extends Label

@onready var game_manager = get_node("../../GameManager")

func _ready():
	game_manager.connect("turn_changed", Callable(self, "_on_turn_changed"))
	game_manager.connect("game_over", Callable(self, "_on_game_over"))

func _on_turn_changed(player_num):
	text = "Player " + str(player_num) + "'s Turn"
	modulate = Color.BLUE if player_num == 1 else Color.RED

func _on_game_over(winner):
	text = "Player " + str(winner) + " Wins!"
	modulate = Color.GREEN
