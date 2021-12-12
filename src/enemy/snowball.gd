class_name Snowball
extends KinematicBody

const PROJECTILE_SPEED = 10

var target: Spatial

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if target:
		var collision = move_and_collide((target.global_transform.origin - self.global_transform.origin).normalized() * PROJECTILE_SPEED * delta)
		if collision:
			print("snowball hit something")
			queue_free()
