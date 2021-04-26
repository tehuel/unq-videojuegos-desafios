extends Node

onready var player = $Player

func _ready():
	player.initialize(self)
