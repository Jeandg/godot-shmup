@tool
extends Node

class_name HealthDepletedCounterComponent

@export var health_component: HealthComponent
var label_visible_duration = 0.3
@onready var canvas_layer = $CanvasLayer

var last_created_label_time = 0
var last_created_label: Label

func _ready():
	if health_component:
		health_component.health_depleted.connect(_on_health_depleted)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if not canvas_layer:
		warnings.append("Node should have a CanvasLayer child")
	return warnings

func _on_health_depleted(new_health, health_depleted):
	_clear_current_displayed_label()
	
	var str_health_depleted = str(health_depleted)
	var label = Label.new()
	var label_settings = LabelSettings.new()
	label.text = str_health_depleted
	label_settings.font_size = 10
	label.position = get_parent().position
	label.label_settings = label_settings
	
	last_created_label = label
	last_created_label_time = 0
	
	canvas_layer.add_child(label)

func _process(delta):
	if last_created_label:
		last_created_label_time += delta
		if last_created_label_time > label_visible_duration:
			_clear_current_displayed_label()

func _clear_current_displayed_label():
	if is_instance_valid(last_created_label):
		last_created_label.queue_free()
