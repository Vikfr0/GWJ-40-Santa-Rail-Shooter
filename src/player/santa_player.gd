class_name SantaPlayer
extends KinematicBody

signal santa_hit
signal santa_coziness_updated

const MAX_ROTATION_VALUE := 1.2

const SNOWBALL_HIT_COZINESS_DECREASE := 2
const KID_RETURNED_COZINESS_INCREASE := 5

const present_bullet: PackedScene = preload("res://src/player/present_projectile.tscn")

var coziness = 100

onready var world = get_tree().get_nodes_in_group("world")[0]

onready var camera_pivot: Spatial = $CameraPivot
onready var projectile_spawn_pos: Spatial = $CameraPivot/ProjectileSpawnPosition
onready var timer: Timer = $CameraPivot/Timer


func _ready():
	for house in get_tree().get_nodes_in_group("house"):
		house.connect("child_returned", self, "_add_coziness")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * Settings.mouse_sensitivity)
		camera_pivot.rotate_x(-event.relative.y * Settings.mouse_sensitivity)
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -MAX_ROTATION_VALUE, MAX_ROTATION_VALUE)


func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot") and timer.is_stopped():
		var projectile = present_bullet.instance()
		projectile.rotation.y = self.rotation.y
		projectile.rotation.x = camera_pivot.rotation.x
		world.add_child(projectile)
		projectile.global_transform.origin = projectile_spawn_pos.global_transform.origin
		
		$AnimationPlayer.play("gun_recoil")
		timer.start()
		


func _add_coziness() -> void:
	coziness += KID_RETURNED_COZINESS_INCREASE
	if coziness > 100:
		coziness = 100
	emit_signal("santa_coziness_updated")


func _on_Area_body_entered(body: Node) -> void:
	if body is Snowball:
		coziness -= SNOWBALL_HIT_COZINESS_DECREASE
		
		emit_signal("santa_hit", body.global_transform.origin)
		
		_play_ouch_audio()
		
		if coziness <= 0:
			emit_signal("game_over")
		else:
			emit_signal("santa_coziness_updated", coziness)
		body.queue_free()


func _play_ouch_audio() -> void:
	$OuchSound.play()
