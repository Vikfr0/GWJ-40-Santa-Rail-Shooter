class_name Snowball
extends KinematicBody

const PROJECTILE_SPEED = 40

var target: Spatial

var direction = null


func _process(delta: float) -> void:
	if direction == null:
		direction = (target.global_transform.origin - self.global_transform.origin).normalized()
	else:
		var collision = move_and_collide(direction * PROJECTILE_SPEED * delta)
		if collision:
			print("snowball hit something")
			queue_free()
