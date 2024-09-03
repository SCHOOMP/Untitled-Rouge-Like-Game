extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -900.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var jumpo_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var double_jump: AudioStreamPlayer2D = $AudioStreamPlayer2D2

var jump_count = 0

func jump():
	velocity.y = JUMP_VELOCITY
	
func hit(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x

	
func _physics_process(delta: float) -> void:
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
		
	# Add the gravity.
	if is_on_floor():
		jump_count = 0
	else:
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_count += 1 
		if jump_count == 1 :
			jumpo_sound.play()
		else:
			double_jump.play()
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
