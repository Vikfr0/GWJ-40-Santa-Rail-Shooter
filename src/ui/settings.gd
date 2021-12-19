extends Control


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_menu") and get_tree().paused:
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		hide()
