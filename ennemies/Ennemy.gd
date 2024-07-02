extends Area2D

var last_hit = 0
var HIT_DURATION = 0.1

@export var health = 3
@export var destroy_score = 5000
@export var time_to_go_through_path = 10
var time_elapsed = 0

@onready var animated_sprite = $AnimatedSprite2D
@onready var path = $Path
@onready var path_follow = $Path2D/PathFollow2D

@onready var explosion_scene = preload("res://explosion/explosion.tscn")

var offset = Vector2()

func _ready():
	offset = Vector2(position.x, position.y)
	# path_follow.h_offset = position.x
	# path_follow.v_offset = position.y
	pass

func _process(delta):
	last_hit += delta
	
	_check_health()
	
	if last_hit > HIT_DURATION:
		animated_sprite.material.set_shader_parameter("damaged", false)
	
	time_elapsed += delta
	
	var progress = time_elapsed / time_to_go_through_path
	
	path_follow.progress_ratio = progress
	position = path_follow.position + offset 
	print(path_follow.position)

func _check_health():
	if health <= 0:
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
	health -= damage

	animated_sprite.material.set_shader_parameter("damaged", true)

func _on_body_entered(body):
	if body.has_method("collides_with_ennemy"):
		body.collides_with_ennemy()
