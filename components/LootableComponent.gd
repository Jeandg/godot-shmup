extends Node

class_name LootableComponent

var power_up_to_loot_scene: PackedScene

func _get_configuration_warnings():
	var warnings = []
	if not power_up_to_loot_scene:
		warnings.append("Should set a power up to loot")
	return warnings

func loot():
	if power_up_to_loot_scene:
		var power_up_to_loot = power_up_to_loot_scene.instantiate()
		power_up_to_loot.position = get_parent().position
		get_tree().current_scene.add_child(power_up_to_loot)
