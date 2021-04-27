extends Node2D

onready var timer = $DeleteTimer 
var speed = 250.0
var direction


func initialize(initial_direction, initial_position):
	global_position = initial_position
	direction = initial_direction
	timer.start()
	
func _physics_process(delta):
	position += direction * speed * delta


func _on_DeleteTimer_timeout():
	get_parent().remove_child(self)
	queue_free()
