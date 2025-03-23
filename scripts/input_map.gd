extends Node2D

func _ready():
	setup_input_mappings()

func setup_input_mappings():
	if not InputMap.has_action("angle_up"):
		InputMap.add_action("angle_up")
		var event = InputEventKey.new()
		event.keycode = KEY_UP
		InputMap.action_add_event("angle_up", event)
	
	if not InputMap.has_action("angle_down"):
		InputMap.add_action("angle_down")
		var event = InputEventKey.new()
		event.keycode = KEY_DOWN
		InputMap.action_add_event("angle_down", event)
	
	if not InputMap.has_action("power_up"):
		InputMap.add_action("power_up")
		var event = InputEventKey.new()
		event.keycode = KEY_RIGHT
		InputMap.action_add_event("power_up", event)
	
	if not InputMap.has_action("power_down"):
		InputMap.add_action("power_down")
		var event = InputEventKey.new()
		event.keycode = KEY_LEFT
		InputMap.action_add_event("power_down", event)
	
	if not InputMap.has_action("launch"):
		InputMap.add_action("launch")
		var event = InputEventKey.new()
		event.keycode = KEY_SPACE
		InputMap.action_add_event("launch", event)
	
	if not InputMap.has_action("next_emoji"):
		InputMap.add_action("next_emoji")
		var event = InputEventKey.new()
		event.keycode = KEY_E
		InputMap.action_add_event("next_emoji", event)
	
	if not InputMap.has_action("prev_emoji"):
		InputMap.add_action("prev_emoji")
		var event = InputEventKey.new()
		event.keycode = KEY_Q
		InputMap.action_add_event("prev_emoji", event)
	
	if not InputMap.has_action("reset_game"):
		InputMap.add_action("reset_game")
		var event = InputEventKey.new()
		event.keycode = KEY_R
		InputMap.action_add_event("reset_game", event)
