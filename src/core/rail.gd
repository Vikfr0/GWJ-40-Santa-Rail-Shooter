extends PathFollow

const SPEED := 6.0

func _process(delta: float) -> void:
	self.offset += delta * SPEED
