extends "../PlayerState.gd"

func _on_enter():
	player.animated_sprite.play("straight")
	pass

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		player.movement_state_machine.change_state(player.state_left, player)
	elif Input.is_action_pressed("ui_right"):
		player.movement_state_machine.change_state(player.state_right, player)
	else:
		pass
