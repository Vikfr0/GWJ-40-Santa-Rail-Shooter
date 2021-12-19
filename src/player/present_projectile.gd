class_name PresentProjectile
extends KinematicBody

const SPEED := 70.0

const explo_particles = preload("res://src/player/present_explosion_particles.tscn")

func _process(delta: float):
	var collision = move_and_collide(global_transform.basis.z.normalized() * -SPEED * delta)
	if collision:
		var parts = explo_particles.instance()
		get_tree().get_nodes_in_group("game")[0].add_child(parts)
		parts.global_transform.origin = self.global_transform.origin
		if collision.collider.get_collision_layer() == 8 or collision.collider.get_collision_layer() == 4:
			queue_free()
