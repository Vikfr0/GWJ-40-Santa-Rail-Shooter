extends Node

const game = preload("res://src/levels/game.tscn")

onready var scene_tree = get_tree()


func load_game() -> void:
	_instantiate_game_world()


func _instantiate_game_world() -> void:
	add_child(game.instance())
	$MasterAnimationPlayer.play("fade_in_game")
	$Intro.queue_free()

