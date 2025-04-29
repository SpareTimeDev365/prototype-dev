extends Node2D

@export var round_limit: int
# @export var ball: RigidBody2D
@onready var p1_score_text: Label = $p1ScoreText
@onready var p2_score_text: Label = $p2ScoreText
@onready var origin: Node2D = $origin

var ball
var p1_score := 0
var p2_score := 0
var current_round := 0
var round_over := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	round_start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	p1_score_text.text = str(p1_score)
	p2_score_text.text = str(p2_score)
	if current_round < round_limit and round_over:
		round_start()
		
# Round Start Actions: Reset ball when the current_round start
func round_start():
	ball = preload("res://scenes/ball.tscn").instantiate()
	ball.position = origin.position
	add_child(ball)
	round_over = false

# Round End Actions
func round_end():
	print("Round:", current_round, " p1: ", p1_score, " ,p2: ", p2_score)
	remove_child(ball)
	round_over = true


func _on_point_area_body_entered(body: Node2D) -> void:
	if (body.name == ball.name and round_over == false):
		print("p2 player score")
		p2_score += 1
		round_end()

func _on_point_area_2_body_entered(body: Node2D) -> void:
	if (body.name == ball.name and round_over == false):
		print("p1 player score")
		p1_score += 1
		round_end()
