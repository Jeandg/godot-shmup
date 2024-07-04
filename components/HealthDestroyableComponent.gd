@tool
extends Node

class_name HealthDestroyableComponent

@export var health_component: HealthComponent = null
@export var destroy_score: int

@onready var explosion_scene = preload("res://explosion/explosion.tscn")

func _ready():
	if health_component:
		health_component.health_depleted.connect(_on_health_depleted)
	
func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if not health_component:
		warnings.append("HealthComponent is required but not assigned!")
	return warnings
	
func _on_health_depleted(new_health: int, amount_depleted: int):
	if new_health <= 0:
		_explode()
		GameState.add_score(destroy_score)
		get_parent().queue_free()

func _explode():
	var explosion_1 = explosion_scene.instantiate()
	var explosion_2 = explosion_scene.instantiate()
	explosion_1.position = get_parent().position + Vector2(0, 0)
	explosion_2.position = get_parent().position + Vector2(3, 3)
	explosion_2.delay = 0.5
	get_tree().current_scene.add_child(explosion_1)
	get_tree().current_scene.add_child(explosion_2)
