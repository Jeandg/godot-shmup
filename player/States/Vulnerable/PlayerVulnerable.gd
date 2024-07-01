extends "../PlayerState.gd"

func _on_enter():
	player.animated_sprite.self_modulate.a = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
