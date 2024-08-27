extends Node

var points = 0
@onready var label: Label = %Label

func add_points():
	points += 1
	print(points)
	label.text = "Points: " + str(points)
