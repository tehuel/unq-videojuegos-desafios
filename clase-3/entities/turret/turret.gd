extends Sprite

onready var cannon = $cannon
var target

func initialize(projectile_container, player):
	target = player
	pass
#	cannon.container = projectile_container

func _physics_process(delta):
	# Movimiento cañon	
	cannon.rotation = (target.global_position - global_position).angle()
