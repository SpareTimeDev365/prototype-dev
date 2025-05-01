extends Node2D

@export var round_limit: int
# @export var ball: RigidBody2D
@onready var p1_score_text: Label = $p1ScoreText
@onready var p2_score_text: Label = $p2ScoreText
@onready var origin: Node2D = $origin
@onready var menu: Panel = $Menu

var ball
var p1_score := 0
var p2_score := 0
var current_round := 0
var round_over := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	round_start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	p1_score_text.text = str(p1_score)
	p2_score_text.text = str(p2_score)
	if current_round < round_limit and round_over:
		round_start()
	#if Input.is_key_pressed(KEY_ESCAPE):
		#print("esc")
		#menu.visible = not menu.visible
		#get_tree().paused = not get_tree().paused
		
## Handle Game Input event (override)	
func _input(event: InputEvent) -> void:
	# NOTE: should be inputEventKey otherwise the event.keycode will error when the mouse click
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_ESCAPE:
			print("esc")
			menu.visible = not menu.visible
			get_tree().paused = not get_tree().paused
		
## Round Start Actions: Reset ball when the current_round start
func round_start():
	ball = preload("res://scenes/ball.tscn").instantiate()
	ball.position = origin.position
	add_child(ball)
	round_over = false

## Round End Actions
func round_end():
	print("Round:", current_round, " p1: ", p1_score, " ,p2: ", p2_score)
	remove_child(ball)
	round_over = true
	


## Signal when ball touch left side
func _on_point_area_body_entered(body: Node2D) -> void:
	if (body.name == ball.name and round_over == false):
		print("p2 player score")
		p2_score += 1
		round_end()

## Singnal when ball touch right side
func _on_point_area_2_body_entered(body: Node2D) -> void:
	if (body.name == ball.name and round_over == false):
		print("p1 player score")
		p1_score += 1
		round_end()

## Singal from reset button pressed
func _on_reset_btn_pressed() -> void:
	p1_score = 0
	p2_score = 0
	round_end()
	round_start()
