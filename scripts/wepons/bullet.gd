extends Area2D

@export var speed = 1500
var damage: int = 0  # Declare a damage variabl

func _ready():
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	position += transform.x * speed * delta

func _physics_process(delta: float) -> void:
	await get_tree().create_timer(0.01).timeout
	set_physics_process(false)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	var damageNum = load("res://scripts/wepons/gun.gd").new()
	print(damageNum.damage)
	if (body is TileMap):
		queue_free()
	elif body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.call("take_damage", damage)  # Call the method to get damage
			print(str(damage))
		queue_free()
