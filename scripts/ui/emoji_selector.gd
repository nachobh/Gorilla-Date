extends HBoxContainer

@onready var game_manager = get_node("../../GameManager")
@onready var emoji_label = $EmojiLabel
@onready var prev_button = $PrevButton
@onready var next_button = $NextButton

func _ready():
	prev_button.pressed.connect(_on_prev_button_pressed)
	next_button.pressed.connect(_on_next_button_pressed)
	game_manager.connect("emoji_selected", Callable(self, "_on_emoji_selected"))
	
	emoji_label.text = game_manager.selected_emoji

func _on_prev_button_pressed():
	game_manager.cycle_emoji(-1)

func _on_next_button_pressed():
	game_manager.cycle_emoji(1)

func _on_emoji_selected(emoji):
	emoji_label.text = emoji
