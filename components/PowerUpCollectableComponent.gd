extends Node

class_name PowerUpCollectableComponent

@export var area: Area2D

var collected_shoot_rate_multipler: Array[float] = []

func _ready():
	area.area_entered.connect(_on_area_entered)
	pass
	
func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if not area:
		warnings.append("Missing area")
	return warnings

func _on_area_entered(body: Area2D):
	if body is PowerUp:
		collected_shoot_rate_multipler.append(body.shoot_rate_multiplier)
		body.queue_free()
