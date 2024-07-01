extends "../PlayerState.gd"

var last_iframe = 0
var IFRAME_DURATION = 2

func _on_enter():
	last_iframe = IFRAME_DURATION

func _process(delta):
	# damage state
	if last_iframe > 0:
		last_iframe -= delta
		player.animated_sprite.self_modulate.a = 0.5
	else:
		player.vulnerability_state_machine.change_state(player.state_vulnerable, player)

