extends "res://scripts/explosion_base.gd"

func _ready():
	particle_count = 50
	particle_color = Color(0.9, 0.2, 0.1)
	particle_spread = 120.0
	particle_size = Vector2(10, 10)
	sound_effect = "res://assets/sounds/explosion.wav"
	
	super._ready()
	
	var timer = Timer.new()
	timer.wait_time = 0.2
	timer.one_shot = true
	timer.timeout.connect(_create_secondary_explosion)
	add_child(timer)
	timer.start()

func _create_secondary_explosion():
	var secondary = CPUParticles2D.new()
	secondary.emitting = true
	secondary.amount = 25
	secondary.lifetime = duration * 0.6
	secondary.explosiveness = 0.9
	secondary.direction = Vector2(0, -1)
	secondary.gravity = Vector2(0, particle_gravity * 0.8)
	secondary.spread = 180.0
	secondary.initial_velocity_min = particle_spread * 0.5
	secondary.initial_velocity_max = particle_spread * 0.8
	secondary.scale_amount = 8
	secondary.color = Color(1.0, 0.8, 0.0)
	add_child(secondary)
