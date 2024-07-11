extends Node

@onready var menu_scene = preload("res://menu/Menu.tscn")

func _ready():
	var menu = menu_scene.instantiate()
	add_child(menu)
	pass
