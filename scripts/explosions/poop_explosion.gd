extends "res://scripts/explosion_base.gd"

func _ready():
	particle_count = 30
	particle_color = Color(0.6, 0.4, 0.2)
	particle_spread = 60.0
	particle_size = Vector2(6, 6)
	sound_effect = "res://assets/sounds/explosion.wav"
	
	super._ready()
