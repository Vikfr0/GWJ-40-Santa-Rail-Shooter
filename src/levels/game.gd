extends Node


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_GameOverArea_body_entered(body: Node) -> void:
	if body is SantaPlayer:
		$Outro/AnimationPlayer.play("outro")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_menu") and not get_tree().paused:
		$Settings.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().set_deferred("paused", true)
