extends Node

@onready var hit: AudioStreamPlayer2D = $AudioStreamPlayer2D3
var points = 0
var hearts = 4
@onready var label: Label = %Label
@export var heart: Array[Node]

# Define the points required for an extra heart
@export var points_per_heart: int = 5
# Define the maximum number of hearts
@export var max_hearts: int = 4

func get_points() -> int:
	return points 

func decrease_health():
	hearts -= 1
	hit.play()
	update_hearts_display()
	if (hearts == 0):
		get_tree().reload_current_scene()

func add_points():
	points += 1
	label.text = "Points: " + str(points)
	check_health_increase()

func check_health_increase():
	# Calculate how many hearts can be added based on points
	var additional_hearts = points / points_per_heart

	# Only increase hearts if the player doesn't exceed max_hearts
	if hearts + additional_hearts > max_hearts:
		hearts = max_hearts
	else:
		hearts += additional_hearts

	# Update points to reflect the increase in health
	points %= points_per_heart  # Reset points after gaining hearts
	update_hearts_display()

func update_hearts_display():
	var max_hearts_count = heart.size()  # Get the actual size of the heart array
	for i in range(max_hearts_count):  # Use the actual size instead of a fixed number
		if (i < hearts):
			heart[i].show()
		else:
			heart[i].hide()
