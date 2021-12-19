extends Spatial

signal child_returned

var max_child_spawned = 9
var child_spawned = 0

export var spawn_start_delay := 3.0
export var spawn_delay := 15.0

const child_enemy = preload("res://src/enemy/kid_enemy.tscn")


onready var timer = $Timer
onready var spawn_pos = $ChildSpawnPosition

func _ready() -> void:
	timer.start(spawn_start_delay)


func _spawn_child_enemy():
	spawn_pos.add_child(child_enemy.instance())
	child_spawned += 1
	
	timer.start(spawn_delay)


func _on_Timer_timeout() -> void:
	if child_spawned < max_child_spawned:
		_spawn_child_enemy()


func _on_Area_body_entered(body: Node) -> void:
	if body is ChildEnemy and body.is_going_home():
		emit_signal("child_returned")
		body.queue_free()
