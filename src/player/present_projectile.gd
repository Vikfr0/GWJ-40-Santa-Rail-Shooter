class_name PresentProjectile
extends KinematicBody

const SPEED := 70.0



func _process(delta: float):
	var _collision = move_and_collide(global_transform.basis.z.normalized() * -SPEED * delta)
