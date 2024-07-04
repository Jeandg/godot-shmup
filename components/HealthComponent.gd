extends Node

class_name HealthComponent

@export var total_health: int = 100
var current_health: int

signal health_depleted(new_health, amount_depleted)
signal health_healed(new_health, amount_healed)

func _ready():
	current_health = total_health
	
func take_damage(amount: int):
	current_health -= amount
	health_depleted.emit(current_health, amount)

func heal(amount: int):
	current_health += amount
	health_healed.emit(current_health, amount)
