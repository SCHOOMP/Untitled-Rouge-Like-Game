extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var game_manager: Node = %GameManager  # Adjust this path accordingly
var health = 2
@export var heart: Array[Control]

var dir: Vector2
var is_enemy_chase: bool = false
var gravity: float = 800.0  # Adjust gravity strength as needed
var speed: float = 100.0  # Speed of enemy movement
var direction: int = 1  # 1 for right, -1 for left
var move_time: float = 0.0  # Timer for movement change
var move_change_interval: float = 2.0  # Time interval to change direction
var stuck_time: float = 0.0  # Timer for how long the enemy has been stuck
var stuck_threshold: float = 1.0  # Time to consider the enemy as stuck
var last_position: Vector2  # Store the last position

func _ready() -> void:
	# Initialize hearts
	update_hearts()
	last_position = position  # Initialize the last position

func _physics_process(delta: float) -> void:
	# Apply gravity (optional, can be removed if not needed)
	if !is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # Reset vertical velocity if on the floor

	# Move the enemy
	move_enemy(delta)

	# Move the character based on the calculated velocity
	move_and_slide()

	# Check for stuck condition
	if position == last_position:
		stuck_time += delta
		if stuck_time >= stuck_threshold:
			print("Enemy is stuck: ", name)  # Print when stuck
	else:
		stuck_time = 0.0  # Reset stuck time if moving

	# Update last position
	last_position = position

	if stuck_time >= stuck_threshold:
		# Change direction if stuck
		direction *= -1  # Switch direction
		print("Enemy freed and changed direction: ", name)  # Print when freed
		stuck_time = 0.0  # Reset stuck timer

func move_enemy(delta: float) -> void:
	# Change direction at intervals
	move_time += delta
	if move_time >= move_change_interval:
		direction = 1 if randi() % 2 == 0 else -1  # Randomly choose left or right
		move_time = 0.0

	# Apply movement in the chosen direction
	velocity.x = speed * direction

	# Flip the sprite based on direction
	if direction == -1:
		animated_sprite_2d.scale.x = -1  # Flip sprite to face left
	else:
		animated_sprite_2d.scale.x = 1  # Face right

func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy took damage! Current health: ", health)
	update_hearts()
	if health <= 0:
		queue_free()

func update_hearts() -> void:
	for i in range(0, heart.size()):
		if i < health:
			heart[i].show()
		else:
			heart[i].hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		
		if y_delta > 30:
			# Handle scenario when character is above the enemy
			if health > 0:
				take_damage(1)
				print("Damage from jumping!")
			body.jump()  # Call the jump method to make the character jump
		else:
			# Handle scenario when character is not above the enemy
			game_manager.decrease_health()
			if x_delta > 0:
				body.hit(500)
			else:
				body.hit(-500)
