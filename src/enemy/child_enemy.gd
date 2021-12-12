extends KinematicBody

const MOVE_SPEED = 10.0
const MAX_RANGE = 20.0

var coziness = 0
var max_coziness = 3

const snowball = preload("res://src/enemy/snowball.tscn")

onready var world = get_tree().get_nodes_in_group("world")[0]
onready var player : KinematicBody = get_tree().get_nodes_in_group("player")[0]

onready var snowball_spawn_pos: Spatial = $SnowballSpawnPosition
onready var timer: Timer = $Timer

func _process(delta: float):
	var distance_to_player := player.global_transform.origin - self.global_transform.origin
	if abs(distance_to_player.length()) > MAX_RANGE:
		# TODO: navigation
		var _collision = move_and_slide(distance_to_player.normalized() * MOVE_SPEED)
	else:
		if timer.is_stopped():
			_throw_snowball()
		pass


func _throw_snowball():
	var projectile = snowball.instance()
	world.add_child(projectile)
	projectile.target = player.get_node("CameraPivot")
	projectile.global_transform.origin = snowball_spawn_pos.global_transform.origin
	timer.start()


func _on_Area_body_entered(body) -> void:
	if body is PresentProjectile:
		body.queue_free()
		coziness += 1
		if coziness >= max_coziness:
			queue_free()
