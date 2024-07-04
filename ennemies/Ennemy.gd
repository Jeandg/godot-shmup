extends Node2D

@export var time_to_go_through_path = 10
var time_elapsed = 0

@onready var path = $Path
@onready var path_follow = $Path2D/PathFollow2D

var offset = Vector2()

func _ready():
	offset = Vector2(position.x, position.y)
	pass

func _process(delta):
	time_elapsed += delta
	
	var progress = time_elapsed / time_to_go_through_path
	
	path_follow.progress_ratio = progress
	position = path_follow.position + offset 
	
func hit(damage):
	$HealthComponent.take_damage(damage)

func _on_body_entered(body):
	if body.has_method("collides_with_ennemy"):
		body.collides_with_ennemy()
