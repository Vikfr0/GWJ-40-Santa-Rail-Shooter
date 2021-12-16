extends TextureRect

const HITMARKER_DIST_PIXELS_FROM_SCREEN_CENTER = 100

onready var player = get_tree().get_nodes_in_group("player")[0]

var center_rect: Vector2

func _ready() -> void:
	player.connect("santa_hit", self, "_display_hitmarker")
	yield(get_tree(),"idle_frame")
	center_rect = self.rect_global_position
	print(center_rect)


func _display_hitmarker(projectile_pos: Vector3) -> void:
	var player_cam = player.get_node("CameraPivot").global_transform.origin
	var incoming_direction = (projectile_pos - player_cam).normalized()
	var angle = rad2deg(player_cam.angle_to(projectile_pos))
	print(angle)
	
	var inc_dir_2d = Vector2(incoming_direction.x, incoming_direction.z)
	var screen_pos = center_rect + inc_dir_2d * HITMARKER_DIST_PIXELS_FROM_SCREEN_CENTER
	self.rect_position = screen_pos
	self.rect_rotation = rad2deg(Vector2.UP.angle_to((screen_pos - center_rect).normalized()))
	#print(self.rect_position)
	#print(self.rect_rotation)
	visible = true
	$Timer.start()


func _on_Timer_timeout() -> void:
	visible = false
