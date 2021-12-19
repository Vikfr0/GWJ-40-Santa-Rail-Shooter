extends CheckBox


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	var world_environment: WorldEnvironment = get_tree().get_nodes_in_group("environment")[0]
	if button_pressed:
		world_environment.environment.ssao_enabled = false
	else:
		world_environment.environment.ssao_enabled = true
