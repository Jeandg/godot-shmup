extends Node

class_name ShootableComponent

@export var weapon: WeaponScene
@export var shoot_origin: Node2D
@export var shoot_direction: Vector2

func _ready():
	get_parent().connect("asked_to_shoot", _on_asked_to_shoot)
	
func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if not get_parent().has_signal("asked_to_shoot"):
		warnings.append("Parent should have asked_to_shoot signal")
	if not weapon:
		warnings.append("Weapon should be specified")
	return warnings
	
func _on_asked_to_shoot():
	weapon.shoot(shoot_direction, shoot_origin.position)
