extends PathFollow

const SPEED := 5.0

func _process(delta: float) -> void:
	self.offset += delta * SPEED
	pass
