extends "res://scripts/explosion_base.gd"

func _ready():
	particle_count = 15
	particle_color = Color(0.1, 0.7, 0.1)
	particle_spread = 90.0
	particle_size = Vector2(5, 5)
	sound_effect = "res://assets/sounds/explosion.wav"
	
	particles.damping = 0.2
	
	super._ready()
