extends Node

var player

func _enter_state(player):
	self.player = player
	_on_enter()

func _on_enter():
	pass
	
func _exit_state():
	_on_exit()
	self.player = null

func _on_exit():
	pass

func _process(delta):
	pass
