extends HBoxContainer

@onready var game_manager = get_node("../../GameManager")
@onready var power_label = $PowerLabel
@onready var power_slider = $PowerSlider

func _ready():
	power_slider.value_changed.connect(_on_power_slider_value_changed)

func _process(delta):
	power_label.text = "Power: " + str(game_manager.power)
	power_slider.value = game_manager.power

func _on_power_slider_value_changed(value):
	game_manager.power = value
