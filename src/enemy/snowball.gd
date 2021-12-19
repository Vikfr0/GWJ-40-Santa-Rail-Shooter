class_name Snowball
extends KinematicBody

const PROJECTILE_SPEED = 70

const SPEED_ADJUSTMENT_DIST = 2.5

var target: Spatial

var direction = null

var exploded = false

onready var sleigh = get_tree().get_nodes_in_group("sleigh")[0]

func _process(delta: float) -> void:
	if direction == null:
		var speed_adjustment = Vector3(SPEED_ADJUSTMENT_DIST, 0, SPEED_ADJUSTMENT_DIST) * -sleigh.get_parent().global_transform.basis.z
		direction = (target.global_transform.origin + speed_adjustment - self.global_transform.origin).normalized()
	else:
		if not exploded:
			var collision = move_and_collide(direction * PROJECTILE_SPEED * delta)
			if collision:
				print("snowball hit: ", collision.collider)
				exploded = true
				$AnimationPlayer.play("explode")
