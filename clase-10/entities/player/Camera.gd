extends Camera2D

onready var animation = $AnimationPlayer

func _on_Player_ice_started():
	animation.play("shake")


func _on_Player_ice_ended():
	animation.stop(true)
