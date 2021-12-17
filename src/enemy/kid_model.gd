extends Spatial


func is_throwing() -> bool:
	return $AnimationPlayer.current_animation == "throw"


func start_run_animation() -> void:
	$AnimationPlayer.play("run")


func start_throw_animation() -> void:
	$AnimationPlayer.play("throw")


func throw_snowball() -> void:
	print("model throwing snowball")
	get_parent().throw_snowball()
