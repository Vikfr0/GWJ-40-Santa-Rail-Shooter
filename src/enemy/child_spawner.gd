extends Spatial

const child_enemy = preload("res://src/enemy/child_enemy.tscn")

onready var world = get_tree().get_nodes_in_group("world")[0]

onready var timer = $Timer
onready var spawn_pos = $ChildSpawnPosition

func _ready() -> void:
	_spawn_child_enemy()


func _spawn_child_enemy():
	spawn_pos.add_child(child_enemy.instance())


func _on_Timer_timeout() -> void:
	_spawn_child_enemy()
