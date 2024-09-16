extends Node

@onready var hit: AudioStreamPlayer2D = $AudioStreamPlayer2D3

var points = 0
var hearts = 4
@onready var label: Label = %Label
@export var heart : Array[Node]

func decrease_health():
	hearts -= 1
	hit.play()
	print(hearts)
	for i in 4:
		if (i < hearts):
			heart[i].show()
		else:
			heart[i].hide()
	if (hearts == 0):
		get_tree().reload_current_scene()

func add_points():
	points += 1
	print(points)
	label.text = "Points: " + str(points)
