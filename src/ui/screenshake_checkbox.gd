extends CheckBox


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	Settings.screenshake_enabled = button_pressed
