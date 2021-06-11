extends "res://entities/enemies/states/AbstractCatState.gd"

onready var boredom_timer:Timer = $BoredomTimer

func enter():
	parent.velocity = Vector2.ZERO
	parent._play_animation(animation_name)
	if parent.navigation != null:
		boredom_timer.start()

func exit():
	boredom_timer.stop()

func update(_delta):
	if parent.target != null && parent.can_see_target():
		emit_signal("finished", CatStateMachine.STATES.SHOOT)
	parent._apply_movement()

func _on_BoredomTimer_timeout():
	if parent.navigation != null:
		emit_signal("finished", CatStateMachine.STATES.PATROL)

