extends Node

class_name WeaponScene

@export var fire_rate: float = 1.0
@export var power_up_collectable: PowerUpCollectableComponent

var time_since_last_shot: float = 0

func _ready():
	# Directly allows to shoot
	time_since_last_shot = fire_rate
	set_process(true)

func _process(delta):
	time_since_last_shot += delta

func can_shoot() -> bool:
	var final_fire_rate = fire_rate
	if power_up_collectable:
		for shoot_rate_multipler in power_up_collectable.collected_shoot_rate_multipler:
			final_fire_rate = final_fire_rate / shoot_rate_multipler
	return time_since_last_shot > final_fire_rate

func shoot(direction: Vector2, origin: Vector2):
	if can_shoot():
		time_since_last_shot = 0
		_shoot(direction, origin)
	pass

func _shoot(direction: Vector2, origin: Vector2):
	#Implement in implementation
	pass
