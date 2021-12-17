extends Camera

export var decay = 0.2  # How quickly the shaking stops [0, 1].

export var max_offset = Vector2(50, 25)  # Maximum hor/ver shake in pixels.

export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

export var snowball_trauma_amount = 0.2


var trauma = 0.0  # Current shake strength.

var trauma_power = 2  # Trauma exponent. Use [2, 3].


func _ready():
	randomize()
	var err = get_parent().get_parent().connect("santa_hit", self, "_add_trauma")
	if err:
		print(err)


func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()


func shake():
	var amount = pow(trauma, trauma_power)
	# rotation = max_roll * amount * rand_range(-1, 1)
	translation.x = max_offset.x * amount * rand_range(-1, 1)
	translation.y = max_offset.y * amount * rand_range(-1, 1)


func _add_trauma(_pos: Vector3):
	if Settings.screenshake_enabled:
		trauma = min(trauma + snowball_trauma_amount, 0.1)
