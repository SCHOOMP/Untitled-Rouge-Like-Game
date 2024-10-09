extends Node2D

var can_fire = true
var BULLET = load("res://scenes/items/bullet.tscn")
var damage: int = 3
@onready var muzzle: Marker2D = $Marker2D  # Attempt to find the muzzle node

func get_damage() -> int:
	return damage
	
func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = BULLET.instantiate()
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation = rotation
		bullet_instance.damage = get_damage()
		get_tree().root.add_child(bullet_instance)
