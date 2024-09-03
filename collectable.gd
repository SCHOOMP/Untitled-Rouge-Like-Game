extends Area2D
@onready var pickup: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
@onready var game_manager: Node = %GameManager


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		audio_stream_player_2d.play()
		queue_free()
		game_manager.add_points()
