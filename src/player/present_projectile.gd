class_name PresentProjectile
extends KinematicBody

const SPEED := 70.0



func _process(delta: float):
	var collision = move_and_collide(global_transform.basis.z.normalized() * -SPEED * delta)
	if collision:
		if collision.collider.get_collision_layer() == 4:
			queue_free()
