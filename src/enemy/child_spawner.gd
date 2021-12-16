extends Spatial

export var spawn_start_delay := 3.0
export var spawn_delay := 6.0

const child_enemy = preload("res://src/enemy/child_enemy.tscn")

onready var world = get_tree().get_nodes_in_group("world")[0]

onready var timer = $Timer
onready var spawn_pos = $ChildSpawnPosition

func _ready() -> void:
	timer.start(spawn_start_delay)


func _spawn_child_enemy():
	spawn_pos.add_child(child_enemy.instance())
	timer.start(spawn_delay)


func _on_Timer_timeout() -> void:
	_spawn_child_enemy()


func _on_Area_body_entered(body: Node) -> void:
	if body is ChildEnemy and body.is_going_home():
		body.queue_free()
