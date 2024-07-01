extends Node

@onready var ennemy_scene = preload("res://ennemies/Ennemy.tscn")
@onready var power_up_scene = preload("res://power_up/power_up.tscn")

func _ready():
	var viewport_width = get_viewport().get_visible_rect().end.x
	get_tree().create_timer(2).timeout.connect(_spawn_ennemy.bind(int(viewport_width / 2), 20))
	get_tree().create_timer(3).timeout.connect(_spawn_ennemy.bind(int(viewport_width) / 2, 20))
	get_tree().create_timer(4).timeout.connect(_spawn_ennemy.bind(int(viewport_width) / 2, 20))
	
	get_tree().create_timer(7).timeout.connect(_spawn_ennemy.bind(int(viewport_width) / 3, 20))
	get_tree().create_timer(8).timeout.connect(_spawn_ennemy.bind(int(viewport_width) / 3, 20))
	get_tree().create_timer(9).timeout.connect(_spawn_ennemy.bind(int(viewport_width) / 3, 20))
	
	get_tree().create_timer(9.5).timeout.connect(_spawn_power_up.bind(int(viewport_width) / 3, 20))
	
	get_tree().create_timer(10).timeout.connect(_spawn_ennemy.bind(int(2 * viewport_width) / 3, 20))
	get_tree().create_timer(11).timeout.connect(_spawn_ennemy.bind(int(2 * viewport_width) / 3, 20))
	get_tree().create_timer(12).timeout.connect(_spawn_ennemy.bind(int(2 * viewport_width) / 3, 20))
	
	print("ready")

func _spawn_ennemy(x, y):
	var ennemy = ennemy_scene.instantiate()
	ennemy.position = Vector2(x, y)
	get_tree().current_scene.add_child(ennemy)

func _spawn_power_up(x, y):
	var power_up = power_up_scene.instantiate()
	power_up.position = Vector2(x, y)
	get_tree().current_scene.add_child(power_up)
