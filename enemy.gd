extends RigidBody2D
@onready var game_manager: Node = %GameManager
var health = 2
@export var heart : Array[Control]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy took damage! Current health: ", health)
	# Ensure we do not go out of bounds
	for i in 2:
		if i < health:
			heart[i].show()
		else:
			heart[i].hide()
	if health <= 0:
		queue_free()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		
		if y_delta > 30:
			# Handle scenario when character is above the enemy
			if health > 0:
				take_damage(1)
				print(str(health) + "from jumping")
			body.jump()
		else:
			# Handle scenario when character is not above the enemy
			game_manager.decrease_health()
			if x_delta > 0:
				body.hit(500)
			else:
				body.hit(-500)
