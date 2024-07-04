extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

var bullet_speed = 250
var bullet_damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	position += Vector2(0, -bullet_speed * delta)
	
	var viewport = get_viewport().get_visible_rect()
	if !viewport.has_point(position):
		queue_free()

func _on_area_entered(area):
	if area.has_method("hit"):
		area.hit(bullet_damage)
		queue_free()
