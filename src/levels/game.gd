extends Node


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_GameOverArea_body_entered(body: Node) -> void:
	if body is SantaPlayer:
		$Outro/AnimationPlayer.play("outro")
