extends "res://entities/player/StateMachine.gd"

enum STATES {
	IDLE,
	WALK,
	ROLL,
	JUMP,
	DEAD
}

var animations_map:Dictionary = {
	STATES.IDLE: "idle",
	STATES.WALK: "walk",
	STATES.ROLL: "roll",
	STATES.JUMP: "jump",
	STATES.DEAD: "dead"
}

func initialize(parent):
	.initialize(parent)
	call_deferred("set_state", STATES.IDLE)

func _state_logic(delta):
	if state != STATES.DEAD:
		parent._handle_cannon_actions()
	
	if state == STATES.IDLE || state == STATES.DEAD:
		parent._handle_deacceleration()
	else:
		parent._handle_move_input()
	parent._apply_movement()

func _get_transition(delta):
	if state != STATES.DEAD && PlayerData.current_health == 0:
		parent.emit_signal("dead")
		return STATES.DEAD
	
	var can_double_jump = 	parent.can_double_jump && state == STATES.JUMP
	var can_simple_jump = 	parent.is_on_floor() && [STATES.IDLE, STATES.WALK].has(state)
	var can_jump = can_simple_jump || can_double_jump
	if Input.is_action_just_pressed("jump") && can_jump:
		if (can_simple_jump):
			parent.can_double_jump = true
		if (can_double_jump):
			parent.can_double_jump = false

		parent.snap_vector = Vector2.ZERO
		parent.velocity.y = -parent.jump_speed
		return STATES.JUMP
	
	match state:
		STATES.IDLE:
			if int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) != 0:
				return STATES.WALK
		STATES.WALK:
			if (Input.is_action_pressed("roll")):
				return STATES.ROLL
			if parent.move_direction == 0:
				return STATES.IDLE
		STATES.ROLL:
			if (!Input.is_action_pressed("roll")):
				return STATES.WALK
		STATES.JUMP:
			if parent.is_on_floor():
				if parent.move_direction != 0:
					return STATES.WALK
				else:
					return STATES.IDLE
	
	return null

func _enter_state(new_state, old_state):
	parent._play_animation(animations_map[new_state])

func _exit_state(old_state, new_state):
	pass
