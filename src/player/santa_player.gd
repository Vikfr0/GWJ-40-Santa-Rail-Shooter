class_name SantaPlayer
extends KinematicBody

signal santa_hit
signal santa_coziness_updated

const MAX_ROTATION_VALUE := 1.2

const SNOWBALL_HIT_COZINESS_DECREASE := 1
const KID_RETURNED_COZINESS_INCREASE := 5

const translate_above_sleigh = Vector3(0, 2, 0)

const present_bullet: PackedScene = preload("res://src/player/present_projectile.tscn")

var coziness = 50

var times_hit = 0

onready var game_world = get_tree().get_nodes_in_group("game")[0]
onready var sleigh = get_tree().get_nodes_in_group("sleigh")[0]

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
	self.global_transform.origin = sleigh.global_transform.origin
	self.translate(translate_above_sleigh)
	if Input.is_action_pressed("shoot") and timer.is_stopped():
		var projectile = present_bullet.instance()
		projectile.rotation.y = self.rotation.y
		projectile.rotation.x = camera_pivot.rotation.x
		game_world.add_child(projectile)
		projectile.global_transform.origin = projectile_spawn_pos.global_transform.origin
		
		$AnimationPlayer.play("gun_recoil")
		$CameraPivot/BFPG/AudioStreamPlayer.play()
		timer.start()
		


func _add_coziness() -> void:
	coziness += KID_RETURNED_COZINESS_INCREASE
	if coziness > 100:
		coziness = 100
	emit_signal("santa_coziness_updated", coziness)


func _on_Area_body_entered(body: Node) -> void:
	print("santa got hit by %s" % body)
	if body is Snowball:
		coziness -= SNOWBALL_HIT_COZINESS_DECREASE
		times_hit += 1
		emit_signal("santa_hit", body.global_transform.origin)
		
		emit_signal("santa_coziness_updated", coziness)
		
		if times_hit == 1:
			$FirstSnowballAudio.play()
			game_world.get_node("AnimationPlayer").play("fade_in_combat_music")
		elif times_hit == 10:
			$PebblesSound.play()
		else:
			_play_ouch_audio()
			
		body.queue_free()


func _play_ouch_audio() -> void:
	if $FirstSnowballAudio.playing == false and $PebblesSound.playing == false:
		$RandomAudioPlayer.play_random_sound()
