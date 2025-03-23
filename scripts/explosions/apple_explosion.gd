extends "res://scripts/explosion_base.gd"

func _ready():
	particle_count = 20
	particle_color = Color(0.8, 0.1, 0.1)
	particle_spread = 70.0
	particle_size = Vector2(5, 5)
	sound_effect = "res://assets/sounds/explosion.wav"
	
	super._ready()
