extends Node

const game = preload("res://src/levels/game.tscn")

onready var scene_tree = get_tree()


func load_game() -> void:
	_instantiate_game_world()


func _instantiate_game_world() -> void:
	add_child(game.instance())
	$MasterAnimationPlayer.play("fade_in_game")
	$Intro.queue_free()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_menu") and not scene_tree.paused:
		$Settings.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		scene_tree.set_deferred("paused", true)

