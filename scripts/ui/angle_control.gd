extends HBoxContainer

@onready var game_manager = get_node("../../GameManager")
@onready var angle_label = $AngleLabel
@onready var angle_slider = $AngleSlider

func _ready():
	angle_slider.value_changed.connect(_on_angle_slider_value_changed)
	game_manager.connect("turn_changed", Callable(self, "_on_turn_changed"))

func _process(delta):
	angle_label.text = "Angle: " + str(game_manager.angle) + "°"

func _on_angle_slider_value_changed(value):
	game_manager.angle = value

func _on_turn_changed(player_num):
	if player_num == 2:
		angle_slider.min_value = 0
		angle_slider.max_value = 90
		angle_slider.step = 1
		angle_slider.value = 180 - game_manager.angle
	else:
		angle_slider.min_value = 0
		angle_slider.max_value = 90
		angle_slider.step = 1
		angle_slider.value = game_manager.angle
