extends PathFollow

const SPEED := 25.0

func _process(delta: float) -> void:
	self.offset += delta * SPEED
