extends Node
@onready var click: AudioStreamPlayer2D = %Click

func _on_level_1_pressed() -> void:
	%Click.play()
	await %Click.finished
	get_tree().change_scene_to_file("res://level1.tscn")


func _on_level_2_pressed() -> void:
	%Click.play()
	await %Click.finished
	get_tree().change_scene_to_file("res://level2.tscn")
