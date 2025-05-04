extends Area2D

@export var ball: RigidBody2D
@onready var audio_player_1: AudioStreamPlayer2D = $"../AudioPlayer1"


func _on_body_entered(body: Node2D) -> void:
	if body.name == ball.name:
		print("ball enter")
		audio_player_1.playing = true
