extends KinematicBody

const MAX_ROTATION_VALUE := 1.2

const present_bullet: PackedScene = preload("res://src/player/present_bullet.tscn")

onready var world = get_tree().get_nodes_in_group("world")

onready var camera_pivot = $CameraPivot

func _ready():
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * Settings.mouse_sensitivity)
		camera_pivot.rotate_x(-event.relative.y * Settings.mouse_sensitivity)
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -MAX_ROTATION_VALUE, MAX_ROTATION_VALUE)


func _process(delta: float) -> void:
	if Input.action_press("shoot"):
		var projectile = present_bullet.instance()
		var spawn_position = self.global_transform.origin + (Vector3.FORWARD * self.rotation.y)
		world.add_child(projectile)
