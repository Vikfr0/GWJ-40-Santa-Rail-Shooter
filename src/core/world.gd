extends Node

const game = preload("res://src/levels/game.tscn")

onready var scene_tree = get_tree()

var loader_thread

func load_game() -> void:
	var loader_thread = Thread.new()
	loader_thread.start(self, "_instantiate_game_world")


func _instantiate_game_world() -> void:
	add_child(game.instance())
	$MasterAnimationPlayer.play("fade_in_game")
	$Intro.queue_free()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_menu") and not scene_tree.paused:
		$Settings.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		scene_tree.set_deferred("paused", true)


func _exit_tree():
	loader_thread.wait_to_finish()
