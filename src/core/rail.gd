extends PathFollow

export var speed := 10.0

func _process(delta: float) -> void:
	self.offset += delta * speed
	pass
