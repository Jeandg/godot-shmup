extends TextureProgressBar

@export var health_component: HealthComponent

func _ready():
	if health_component:
		health_component.health_depleted.connect(_on_health_depleted)
		health_component.health_healed.connect(_on_health_healed)
		max_value = 100
		value = max_value
	set_process(true)

func _on_health_depleted(new_health, amount_depleted):
	value = new_health

func _on_health_healed(new_health, amount_healed):
	value = new_health
