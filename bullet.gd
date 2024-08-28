extends Area2D


@export var speed = 1500

func _process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	
func _physics_process(delta: float) -> void:
	await get_tree().create_timer(0.01).timeout
	set_physics_process(false)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
