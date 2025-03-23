extends "res://scripts/explosion_base.gd"

func _ready():
	particle_count = 25
	particle_color = Color(0.1, 0.1, 0.1)
	particle_spread = 110.0
	particle_size = Vector2(7, 7)
	sound_effect = "res://assets/sounds/explosion.wav"
	
	super._ready()

	var number_particles = CPUParticles2D.new()
	number_particles.emitting = true
	number_particles.amount = 8  # One for each number 1-8
	number_particles.lifetime = duration
	number_particles.explosiveness = 0.9
	number_particles.direction = Vector2(0, -1)
	number_particles.gravity = Vector2(0, particle_gravity)
	number_particles.spread = 180.0
	number_particles.initial_velocity_min = particle_spread * 0.6
	number_particles.initial_velocity_max = particle_spread * 0.9
	number_particles.scale_amount = 5
	number_particles.color = Color(1.0, 1.0, 1.0)  # White
	add_child(number_particles)
