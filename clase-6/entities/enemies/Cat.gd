extends RigidBody2D

onready var fire_position = $FirePosition
onready var fire_timer = $FireTimer
onready var raycast = $FirePosition/RayCast2D
onready var remove_anim_player = $RemoveAnimPlayer

onready var body_sprite = $Body

export (PackedScene) var projectile_scene

var target
var projectile_container

func _ready():
	fire_timer.connect("timeout", self, "fire")
	set_physics_process(false)

func initialize(container, turret_pos, projectile_container):
	container.add_child(self)
	global_position = turret_pos
	self.projectile_container = projectile_container

func fire():
	if target != null:
		body_sprite.play("spit")
		var proj_instance = projectile_scene.instance()
		if projectile_container == null:
			projectile_container = get_parent()
		proj_instance.initialize(projectile_container, fire_position.global_position, fire_position.global_position.direction_to(target.global_position))
		fire_timer.start()

func _physics_process(delta):
	body_sprite.flip_h = global_position.direction_to(target.global_position).x < 0
	raycast.set_cast_to(to_local(target.global_position))
	if raycast.is_colliding() && raycast.get_collider() == target:
		if fire_timer.is_stopped():
			fire_timer.start()
	elif !fire_timer.is_stopped():
		fire_timer.stop()


func notify_hit(_amount):
	if body_sprite.animation == "dead":
		return
	body_sprite.play("dead")
	raycast.collision_mask = 0
	yield(body_sprite,"animation_finished")
	remove_anim_player.play("remove")

func _remove():
	get_parent().remove_child(self)
	queue_free()


func _on_DetectionArea_body_entered(body):
	if target == null:
		target=body
		set_physics_process(true)

func _on_DetectionArea_body_exited(body):
	if body == target:
		target = null
		set_physics_process(false)


func _on_Body_animation_finished():
	if body_sprite.animation == "spit":
		body_sprite.play("idle")
