extends Node

@onready var ennemy_small_scene = preload("res://ennemies/Small/ennemy_small.tscn")
@onready var ennemy_medium_scene = preload("res://ennemies/Medium/ennemy_medium.tscn")
@onready var ennemy_big_scene = preload("res://ennemies/Big/ennemy_big.tscn")
@onready var power_up_scene = preload("res://power_up/power_up.tscn")

func _ready():
	var viewport_width = get_viewport().get_visible_rect().end.x
	
	var viewport_center = int(viewport_width / 2)
	var viewport_left = int(viewport_width) / 3
	var viewport_right = int(2 * viewport_width) / 3
	
	get_tree().create_timer(2).timeout.connect(_spawn_ennemy.bind(viewport_center, 20, ENNEMY_TYPE.SMALL))
	get_tree().create_timer(3).timeout.connect(_spawn_ennemy.bind(viewport_center, 20, ENNEMY_TYPE.SMALL))
	get_tree().create_timer(4).timeout.connect(_spawn_ennemy.bind(viewport_center, 20, ENNEMY_TYPE.SMALL))
	
	get_tree().create_timer(7).timeout.connect(_spawn_ennemy.bind(viewport_left, 20, ENNEMY_TYPE.MEDIUM))
	get_tree().create_timer(8).timeout.connect(_spawn_ennemy.bind(viewport_left, 20, ENNEMY_TYPE.MEDIUM))
	get_tree().create_timer(9).timeout.connect(_spawn_ennemy.bind(viewport_left, 20, ENNEMY_TYPE.MEDIUM))
	
	get_tree().create_timer(9.5).timeout.connect(_spawn_power_up.bind(viewport_left, 20))
	
	get_tree().create_timer(10).timeout.connect(_spawn_ennemy.bind(viewport_right, 20, ENNEMY_TYPE.BIG))
	get_tree().create_timer(11).timeout.connect(_spawn_ennemy.bind(viewport_right, 20, ENNEMY_TYPE.BIG))
	get_tree().create_timer(12).timeout.connect(_spawn_ennemy.bind(viewport_right, 20, ENNEMY_TYPE.BIG))
	

enum ENNEMY_TYPE {SMALL, MEDIUM, BIG}

func _spawn_ennemy(x, y, type):
	var ennemy
	
	match type:
		ENNEMY_TYPE.SMALL:
			ennemy = ennemy_small_scene.instantiate()
		ENNEMY_TYPE.MEDIUM:
			ennemy = ennemy_medium_scene.instantiate()
		ENNEMY_TYPE.BIG:
			ennemy = ennemy_big_scene.instantiate()
		
	ennemy.position = Vector2(x, y)
	get_tree().current_scene.add_child(ennemy)

func _spawn_power_up(x, y):
	var power_up = power_up_scene.instantiate()
	power_up.position = Vector2(x, y)
	get_tree().current_scene.add_child(power_up)
