extends HSlider




func _on_HSlider_value_changed(value: float) -> void:
	Settings.set_mouse_sentivity(value)
