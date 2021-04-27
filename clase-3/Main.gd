extends Node

const min_position = Vector2(100, 50)
const max_position = Vector2(700, 250)

export (PackedScene) var turret_scene

onready var player = $Player

var rng = RandomNumberGenerator.new()

func _ready():
	player.initialize(self)
	
	for i in range(3):
		var new_turret = turret_scene.instance()
		add_child(new_turret)
		new_turret.global_position = _get_random_position()
		new_turret.initialize(self, player)

func _get_random_position():
	rng.randomize()
	var pos_x = rng.randf_range(min_position.x, max_position.x)
	var pos_y = rng.randf_range(min_position.y, max_position.y)
	return Vector2(pos_x, pos_y)
