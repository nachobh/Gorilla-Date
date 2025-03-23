extends Node2D

@export var duration: float = 0.8
@export var particle_count: int = 20
@export var particle_size: Vector2 = Vector2(5, 5)
@export var particle_color: Color = Color.YELLOW
@export var particle_spread: float = 100.0
@export var particle_gravity: float = 98.0
@export var sound_effect: String = "res://assets/sounds/explosion.wav"

@onready var particles = $CPUParticles2D
@onready var audio_player = $AudioStreamPlayer

func _ready():
	particles.emitting = true
	particles.amount = particle_count
	particles.lifetime = duration
	particles.explosiveness = 0.9
	particles.direction = Vector2(0, -1)
	particles.gravity = Vector2(0, particle_gravity)
	particles.spread = 180.0
	particles.initial_velocity_min = particle_spread * 0.7
	particles.initial_velocity_max = particle_spread
	particles.scale_amount = particle_size.x / 5.0 
	particles.color = particle_color
	
	var sound = load(sound_effect)
	if sound:
		audio_player.stream = sound
		audio_player.play()
	
	var timer = Timer.new()
	timer.wait_time = duration + 0.2
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.start()

func _on_timeout():
	queue_free()
