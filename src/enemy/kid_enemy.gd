class_name ChildEnemy
extends KinematicBody

const MOVE_SPEED = 14.0
const MAX_RANGE = 24.0

var coziness = 0
var max_coziness = 3

const snowball = preload("res://src/enemy/snowball.tscn")

onready var world = get_tree().get_nodes_in_group("game")[0]
onready var player : KinematicBody = get_tree().get_nodes_in_group("player")[0]
onready var home : Spatial = get_parent().get_parent().get_parent()

onready var model: Spatial = $kid
onready var snowball_spawn_pos: Spatial = $SnowballSpawnPosition
onready var timer: Timer = $Timer

enum States { gonna_f_up_santa, going_home }
var state = States.gonna_f_up_santa

func is_going_home():
	return state == States.going_home


func throw_snowball():
	print("throwing snowball")
	var projectile = snowball.instance()
	projectile.target = player.get_node("CameraPivot")
	
	world.add_child(projectile)
	projectile.global_transform.origin = snowball_spawn_pos.global_transform.origin




func _process(_delta: float):
	var child_pos: Vector3 = self.global_transform.origin
	if state == States.gonna_f_up_santa:
		look_at(player.global_transform.origin, Vector3.UP)
		self.rotation.x = 0
		self.rotation.z = 0
		var distance_to_player := player.global_transform.origin - child_pos
		if abs(distance_to_player.length()) > MAX_RANGE:
			distance_to_player.y = 0
			var _collision = move_and_slide(distance_to_player.normalized() * MOVE_SPEED)
			model.start_run_animation()
		else:
			_start_throwing_snowball()
	elif state == States.going_home:
		var home_pos = home.global_transform.origin
		look_at(home_pos, Vector3.UP)
		self.rotation.x = 0
		self.rotation.z = 0
		home_pos.y = 0
		child_pos.y = 0
		var direction = (home_pos - child_pos)
		var _collision = move_and_slide(direction.normalized() * MOVE_SPEED)
		model.start_run_animation()


func _start_throwing_snowball():
	if timer.is_stopped() and not model.is_throwing():
		model.start_throw_animation()
		timer.start()


func _on_Area_body_entered(body) -> void:
	if body is PresentProjectile:
		body.queue_free()
		coziness += 1
		if coziness >= max_coziness:
			state = States.going_home
