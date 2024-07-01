extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

var shoot_rate_multiplier = 1.5

func _ready():
	animated_sprite.play("default")

func _process(delta):
	position = Vector2(position.x, position.y + delta * 50)
