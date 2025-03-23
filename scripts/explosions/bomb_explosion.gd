extends "res://scripts/explosion_base.gd"

func _ready():
	particle_count = 40
	particle_color = Color(0.2, 0.2, 0.2)
	particle_spread = 150.0
	particle_size = Vector2(8, 8)
	sound_effect = "res://assets/sounds/explosion.wav"
	
	super._ready()
	
	var smoke_particles = CPUParticles2D.new()
	smoke_particles.emitting = true
	smoke_particles.amount = 15
	smoke_particles.lifetime = duration * 1.5
	smoke_particles.explosiveness = 0.7
	smoke_particles.direction = Vector2(0, -1)
	smoke_particles.gravity = Vector2(0, -20) 
	smoke_particles.spread = 180.0
	smoke_particles.initial_velocity_min = 30
	smoke_particles.initial_velocity_max = 50
	smoke_particles.scale_amount = 10
	smoke_particles.color = Color(0.5, 0.5, 0.5, 0.7) 
	add_child(smoke_particles)
