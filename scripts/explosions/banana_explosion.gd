extends "res://scripts/explosion_base.gd"

func _ready():
	particle_count = 25
	particle_color = Color(1.0, 0.92, 0.16)
	particle_spread = 80.0
	particle_size = Vector2(6, 6)
	sound_effect = "res://assets/sounds/explosion.wav"
	
	super._ready()
