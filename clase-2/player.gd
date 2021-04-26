extends Sprite

export var speed = 300

func _process(delta):
	var left  = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var direction = int(right) - int(left)
	position.x += direction * speed * delta
