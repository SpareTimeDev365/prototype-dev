extends Node2D

@export var ball: RigidBody2D
@onready var p1_score_text: Label = $p1ScoreText
@onready var p2_score_text: Label = $p2ScoreText
@onready var origin: Node2D = $origin

var p1_score := 0
var p2_score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("game ready1")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	p1_score_text.text = str(p1_score)
	p2_score_text.text = str(p2_score)

func _on_point_area_body_entered(body: Node2D) -> void:
	if (body.name == ball.name):
		print("p2 player score")
		p2_score += 1
		print("p1: ", p1_score, " ,p2: ", p2_score)

func _on_point_area_2_body_entered(body: Node2D) -> void:
	if (body.name == ball.name):
		print("p1 player score")
		p1_score += 1
		print("p1: ", p1_score, " ,p2: ", p2_score)
