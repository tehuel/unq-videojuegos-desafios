extends Sprite

onready var cannon = $cannon
onready var timer = $ShootTimer
onready var attack_sound = $AttackSound
var target

var rng = RandomNumberGenerator.new()

func initialize(projectile_container, player):
	cannon.container = projectile_container
	target = player
	rng.randomize()
	timer.wait_time = rng.randf_range(2, 5)
	timer.start()

func _physics_process(delta):
	# Movimiento cañon	
	cannon.rotation = (target.global_position - global_position).angle()

func _on_ShootTimer_timeout():
	attack_sound.play()
	cannon.fire()
