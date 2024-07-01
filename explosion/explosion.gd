extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

var delay = 0

func _ready():
	await get_tree().create_timer(delay).timeout
	animated_sprite.play("explosion_1")
	animated_sprite.connect("animation_finished", _animation_finished)

func _animation_finished():
	queue_free()
