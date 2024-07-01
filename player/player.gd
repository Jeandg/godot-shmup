extends Area2D

var speed = 1.5
var velocity = Vector2()

# Sprites : https://ansimuz.itch.io/spaceship-shooter-environment
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

@onready var movement_state_machine = preload("res://player/StateMachine.gd").new()
@onready var state_straight = preload("res://player/States/PlayerDirection/PlayerStraightState.gd").new()
@onready var state_left = preload("res://player/States/PlayerDirection/PlayerLeftState.gd").new()
@onready var state_right = preload("res://player/States/PlayerDirection/PlayerRightState.gd").new()

@onready var vulnerability_state_machine = preload("res://player/StateMachine.gd").new()
@onready var state_vulnerable = preload("res://player/States/Vulnerable/PlayerVulnerable.gd").new()
@onready var state_invulnerable = preload("res://player/States/Vulnerable/PlayerInvulnerable.gd").new()

@onready var bullet_scene = preload("res://bullet/bullet.tscn")

var last_shoot = 0

var BASE_SHOOT_INTERVAL = 0.5
var shoot_interval_power_ups = []

# Called when the node enters the scene tree for the first time.
func _ready():
	movement_state_machine.change_state(state_straight, self)
	vulnerability_state_machine.change_state(state_invulnerable, self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	last_shoot += delta
	
	if Input.is_action_pressed("ui_select"):
		_shoot()
	
	_move_and_slide()
	
	movement_state_machine._process(delta)
	vulnerability_state_machine._process(delta)

func _move_and_slide():
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	var viewport = get_viewport().get_visible_rect()
	
	if position.x - 1 < 0 && velocity.x < 0:
		velocity.x = 0
	
	if position.x + 1 > viewport.end.x && velocity.x > 0:
		velocity.x = 0
		
	if position.y + 1 > viewport.end.y && velocity.y > 0:
		velocity.y = 0
		
	if position.y - 1 < 0 && velocity.y < 0:
		velocity.y = 0
	
	position = position + velocity

func _shoot():
	if last_shoot > _get_shoot_interval():
		var bullet = bullet_scene.instantiate()
		bullet.position = position + Vector2(0, -22)
		get_tree().current_scene.add_child(bullet)
		last_shoot = 0
	
func apply_power_up(power_up):
	print(power_up.get_property_list())
	if "shoot_rate_multiplier" in power_up:
		shoot_interval_power_ups.append(power_up.shoot_rate_multiplier)
	
func _get_shoot_interval():
	var total_multipler = 0
	
	if shoot_interval_power_ups.is_empty():
		total_multipler = 1
	else:
		for i in shoot_interval_power_ups:
			total_multipler+=i
	
	print("interval")
	print(BASE_SHOOT_INTERVAL / total_multipler)
	return BASE_SHOOT_INTERVAL / total_multipler

func collides_with_ennemy():
	vulnerability_state_machine.change_state(state_invulnerable, self)

func _on_area_entered(area):
	if area.is_in_group("ennemies"):
		collides_with_ennemy()
	elif area.is_in_group("power_ups"):
		apply_power_up(area)
		area.queue_free()