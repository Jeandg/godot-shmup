extends Area2D

var last_hit = 0
var HIT_DURATION = 0.1

var life = 3
var destroy_score = 1000

@onready var animated_sprite = $AnimatedSprite2D

@onready var explosion_scene = preload("res://explosion/explosion.tscn")

func _process(delta):
	last_hit += delta
	
	_check_health()
	
	if last_hit > HIT_DURATION:
		animated_sprite.material.set_shader_parameter("damaged", false)
		
	position = Vector2(position.x, position.y + delta * 40)

func _check_health():
	if life <= 0:
		var explosion_1 = explosion_scene.instantiate()
		var explosion_2 = explosion_scene.instantiate()
		explosion_1.position = position + Vector2(0, 0)
		explosion_2.position = position + Vector2(3, 3)
		explosion_2.delay = 0.5
		get_tree().current_scene.add_child(explosion_1)
		get_tree().current_scene.add_child(explosion_2)
		GameState.add_score(destroy_score)
		queue_free()
	
func hit(damage):
	last_hit = 0
	life -= damage

	animated_sprite.material.set_shader_parameter("damaged", true)

func _on_body_entered(body):
	if body.has_method("collides_with_ennemy"):
		body.collides_with_ennemy()
