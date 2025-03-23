extends "res://scripts/explosion_base.gd"

func _ready():
	particle_count = 35
	particle_color = Color(1.0, 0.3, 0.0) 
	particle_spread = 100.0
	particle_size = Vector2(7, 7)
	sound_effect = "res://assets/sounds/explosion.wav"
	
	super._ready()

	var flame_particles = CPUParticles2D.new()
	flame_particles.emitting = true
	flame_particles.amount = 20
	flame_particles.lifetime = duration * 1.2
	flame_particles.explosiveness = 0.5
	flame_particles.direction = Vector2(0, -1)
	flame_particles.gravity = Vector2(0, -40)  # Flames rise
	flame_particles.spread = 30.0
	flame_particles.initial_velocity_min = 40
	flame_particles.initial_velocity_max = 80
	flame_particles.scale_amount = 8
	flame_particles.color = Color(1.0, 0.5, 0.0)  # Orange
	add_child(flame_particles)
