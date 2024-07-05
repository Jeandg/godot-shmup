extends WeaponScene

class_name BulletLaserWeapon

@export var bullet_laser_scene: PackedScene

func _shoot(direction: Vector2, origin: Vector2):
	var bullet_laser = bullet_laser_scene.instantiate()
	bullet_laser.position = get_parent().position + origin
	bullet_laser.rotation = get_parent().rotation
	bullet_laser.direction = direction
	get_tree().current_scene.add_child(bullet_laser)
