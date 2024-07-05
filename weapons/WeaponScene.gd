extends Node

class_name WeaponScene

@export var fire_rate: float = 1.0
var time_since_last_shot: float = 0

func _ready():
	# Directly allows to shoot
	time_since_last_shot = fire_rate
	set_process(true)

func _process(delta):
	time_since_last_shot += delta

func can_shoot() -> bool:
	return time_since_last_shot > fire_rate

func shoot(direction: Vector2, origin: Vector2):
	if can_shoot():
		time_since_last_shot = 0
		_shoot(direction, origin)
	pass

func _shoot(direction: Vector2, origin: Vector2):
	#Implement in implementation
	pass
