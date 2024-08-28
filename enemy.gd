extends RigidBody2D

@onready var game_manager: Node = %GameManager
var health = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if (y_delta > 30):
			if (health == 1):
				queue_free()
			else:
				health -= 1
				print ("Hit Enemy")
			body.jump()
		else:
			print("player loosed helth")
			game_manager.decrease_health()
			if (x_delta > 0):
				body.hit(500)
			else:
				body.hit(-500)
