@tool
extends Node

class_name VisibleHittableComponent

@export var animated_sprite: AnimatedSprite2D
@export var health_component: HealthComponent
@export var flash_duration = 0.1

var current_flash_duration = 0

@onready var flash_shader = preload("res://ennemies/EnnemyFlash.gdshader")

func _ready():
	var shader_material = ShaderMaterial.new()
	shader_material.shader = flash_shader
	animated_sprite.material = shader_material
	animated_sprite.material.set_shader_parameter("damaged", false)
	if health_component:
		health_component.health_depleted.connect(_on_health_depleted)

func _on_health_depleted(new_health, amount_depleted):
	current_flash_duration = 0
	animated_sprite.material.set_shader_parameter("damaged", true)
	pass

func _process(delta):
	if animated_sprite.material.get_shader_parameter("damaged"):
		current_flash_duration += delta
		if current_flash_duration > flash_duration:
			animated_sprite.material.set_shader_parameter("damaged", false)
