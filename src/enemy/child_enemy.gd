class_name ChildEnemy
extends KinematicBody

const MOVE_SPEED = 14.0
const MAX_RANGE = 24.0

var coziness = 0
var max_coziness = 3

const snowball = preload("res://src/enemy/snowball.tscn")

onready var world = get_tree().get_nodes_in_group("world")[0]
onready var player : KinematicBody = get_tree().get_nodes_in_group("player")[0]
onready var home : Spatial = get_parent()
onready var navigation: Navigation = get_tree().get_nodes_in_group("navigation")[0]

onready var snowball_spawn_pos: Spatial = $SnowballSpawnPosition
onready var timer: Timer = $Timer

enum States { gonna_f_up_santa, going_home }
var state = States.gonna_f_up_santa

func is_going_home():
	return state == States.going_home


func _process(_delta: float):
	if state == States.gonna_f_up_santa:
		look_at(player.global_transform.origin, Vector3.UP)
		var distance_to_player := player.global_transform.origin - self.global_transform.origin
		if abs(distance_to_player.length()) > MAX_RANGE:
			#var path = navigation.get_simple_path(self.global_transform.origin, player.global_transform.origin)
			#if path.size() > 0:
			#	var _collision = move_and_slide((path[0] - self.global_transform.origin) * MOVE_SPEED)
			#else:
			#	print("player not found in nav")
			distance_to_player.y = 0
			var _collision = move_and_slide(distance_to_player.normalized() * MOVE_SPEED)
		else:
			if timer.is_stopped():
				_throw_snowball()
			pass
	elif state == States.going_home:
		var home_pos = home.global_transform.origin
		look_at(home_pos, Vector3.UP)
		var direction = (home_pos - player.global_transform.origin)
		var _collision = move_and_slide(direction.normalized() * MOVE_SPEED)


func _throw_snowball():
	var projectile = snowball.instance()
	projectile.target = player.get_node("CameraPivot")
	
	world.add_child(projectile)
	projectile.global_transform.origin = snowball_spawn_pos.global_transform.origin

	timer.start()


func _on_Area_body_entered(body) -> void:
	if body is PresentProjectile:
		body.queue_free()
		coziness += 1
		if coziness >= max_coziness:
			state = States.going_home
