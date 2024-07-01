extends Node

var current_state

func change_state(new_state, player):
	if current_state != null:
		current_state._exit_state()
	current_state = new_state
	current_state._enter_state(player)

func _process(delta):
	if current_state != null:
		current_state._process(delta)
