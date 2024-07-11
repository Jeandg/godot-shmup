extends Node

@onready var play_button = $VBoxContainer/PlayButton
@onready var play_endless_button =$VBoxContainer/PlayEndlessButton
@onready var highscores_button =$VBoxContainer/HighscoresButton
@onready var quit_button =$VBoxContainer/QuitButton

var selected_button_index = 0
var selectable_buttons: Array[Button]

@onready var level_1_scene = preload("res://levels/level_1/level_1.tscn")

func _ready():
	play_button.set_pressed_no_signal(true)
	selectable_buttons = [play_button, quit_button]
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed():
	var level_1 = level_1_scene.instantiate()
	get_tree().change_scene_to_packed(level_1_scene)
	
func _on_quit_pressed():
	get_tree().quit()
	
func _process(delta):
	var index_to_add = 0
	
	if Input.is_action_just_pressed("ui_down"):
		index_to_add = 1
	elif Input.is_action_just_pressed("ui_up"):
		index_to_add = -1
	elif Input.is_action_just_pressed("ui_accept"):
		selectable_buttons[selected_button_index].emit_signal("pressed")

	if index_to_add != 0:
		selectable_buttons[selected_button_index].set_pressed_no_signal(false)
		
		if selected_button_index + index_to_add >= selectable_buttons.size():
			selected_button_index = 0
		elif selected_button_index + index_to_add < 0:
			selected_button_index = selectable_buttons.size() - 1
		else:
			selected_button_index += index_to_add
		
		selectable_buttons[selected_button_index].set_pressed_no_signal(true)
