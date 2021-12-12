extends Timer

export var seconds_to_destruction := 5.0

func _ready():
	start(seconds_to_destruction)


func _on_SelfDestructTimer_timeout() -> void:
	get_parent().queue_free()
