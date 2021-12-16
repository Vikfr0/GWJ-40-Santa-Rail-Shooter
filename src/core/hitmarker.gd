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
	var player_cam: Spatial = player.get_node("CameraPivot")
	
	var looking_direction = -player_cam.get_global_transform().basis.z
	
	# projectile_pos.y = 0
	
	# var incoming_direction = (projectile_pos - player_cam).normalized()
	
	var projectile_incoming_direction = projectile_pos - player_cam.get_global_transform().origin
	
	var angle = looking_direction.angle_to(projectile_incoming_direction)
	printt("proj_pos: " + str(projectile_pos), "player_cam_pos: " + str(player_cam.get_global_transform().origin), 
		"looking_dir: " + str(looking_direction), "incoming_dir:" + str(projectile_incoming_direction), 
		"angle: " + str(rad2deg(angle)))
	
	self.rect_position = center_rect + Vector2(0, -HITMARKER_DIST_PIXELS_FROM_SCREEN_CENTER).rotated(angle)
	self.rect_rotation = rad2deg(angle)
	
	# var inc_dir_2d = Vector2(incoming_direction.x, incoming_direction.z) * Vector3.FORWARD.angle_to(player_cam)
	#var screen_pos = center_rect + inc_dir_2d * HITMARKER_DIST_PIXELS_FROM_SCREEN_CENTER
	#self.rect_position = screen_pos
	#self.rect_rotation = rad2deg(Vector2.UP.angle_to((screen_pos - center_rect).normalized()))
	#print(self.rect_position)
	#print(self.rect_rotation)
	visible = true
	$Timer.start()


func _on_Timer_timeout() -> void:
	visible = false
