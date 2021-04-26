extends Sprite

var speed = 200 #Pixeles

onready var cannon = $Cannon

func initialize(projectile_container):
	cannon.container = projectile_container

func _physics_process(delta):
	
	# Movimiento cañon
	cannon.rotation = get_local_mouse_position().angle()
	
	# Movimiento
	var right_as_int = int(Input.is_action_pressed("move_right"))
	var left_as_int = int(Input.is_action_pressed("move_left"))
	var direction_optimized = right_as_int - left_as_int
	position.x += direction_optimized * speed * delta
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire()
	
