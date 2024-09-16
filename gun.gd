extends Sprite2D

var can_fire = true
var bullet = preload("res://bullet.tscn")
	
func _physics_process(delta: float) -> void:
	position.x = lerp(position.x, get_parent().position.x, 0.5)
	position.y = lerp(position.y, get_parent().position.y+10, 0.5)
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance  = bullet.instantiate()
		bullet_instance.rotation = rotation
		get_parent().add_child(bullet_instance)
