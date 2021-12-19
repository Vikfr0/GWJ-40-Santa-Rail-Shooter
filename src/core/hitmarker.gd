extends TextureRect

const HITMARKER_DIST_PIXELS_FROM_SCREEN_CENTER = 150

onready var player = get_tree().get_nodes_in_group("player")[0]

var center_rect: Vector2

func _ready() -> void:
	player.connect("santa_hit", self, "_display_hitmarker")
	yield(get_tree(),"idle_frame")
	center_rect = self.rect_global_position


func _display_hitmarker(projectile_pos: Vector3) -> void:
	var player_cam: Spatial = player.get_node("CameraPivot")
	var player_cam_pos = player_cam.get_global_transform().origin
	
	projectile_pos.y = 0
	player_cam_pos.y = 0
	
	
	var projectile_incoming_direction = projectile_pos - player_cam_pos
	
	var looking_direction: Vector3 = -player_cam.get_global_transform().basis.z
	
	
	var angle = looking_direction.angle_to(projectile_incoming_direction)
	
	if looking_direction.z - projectile_incoming_direction.z > 0:
		angle = -angle
	
	#printt("proj_pos: " + str(projectile_pos), "player_cam_pos: " + str(player_cam.get_global_transform().origin), 
	#	"looking_dir: " + str(looking_direction), "incoming_dir:" + str(projectile_incoming_direction), 
	#	"angle: " + str(rad2deg(angle)))
	
	self.rect_position = center_rect + Vector2(0, -HITMARKER_DIST_PIXELS_FROM_SCREEN_CENTER).rotated(angle)
	self.rect_rotation = rad2deg(angle)

	visible = true
	$Timer.start()


func _on_Timer_timeout() -> void:
	visible = false
