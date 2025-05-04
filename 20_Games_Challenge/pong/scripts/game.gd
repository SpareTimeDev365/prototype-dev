extends Node2D

## restrict the round limit that the user can set
@export var max_target_point: int = 10
@export var init_target_point: int = 3

@onready var p1_score_text: Label = $p1ScoreText
@onready var p2_score_text: Label = $p2ScoreText
@onready var paddle: StaticBody2D = $paddle
@onready var paddle_2: StaticBody2D = $paddle2
@onready var origin: Node2D = $origin
@onready var paused_menu: Panel = $pausedMenu
@onready var start_menu: Panel = $startMenu
@onready var game_over_menu: Panel = $gameOverMenu
@onready var audio_player_1: AudioStreamPlayer2D = $AudioPlayer1

var ball
var p1_score := 0
var p2_score := 0
var current_round := 0
var target_point: int
var round_over := false
var game_start: bool = false
var resultTextLabel: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_point = init_target_point
	start_menu.visible = true
	paused_menu.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	resultTextLabel = game_over_menu.find_child("resultLabel")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	p1_score_text.text = str(p1_score)
	p2_score_text.text = str(p2_score)

	if p1_score == target_point or p2_score == target_point:
		game_over_menu.visible = true
		resultTextLabel = game_over_menu.find_child("resultLabel")

		if p1_score > p2_score:
			resultTextLabel.text = "Player 1 win !"
		else:
			resultTextLabel.text = "Player 2 win !"
	elif round_over and game_start:
		round_start()
		
## Handle Game Input event (override)	
func _input(event: InputEvent) -> void:
	# NOTE: should be inputEventKey otherwise the event.keycode will error when the mouse click
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_ESCAPE:
			print("esc")
			paused_menu.visible = not paused_menu.visible
			get_tree().paused = not get_tree().paused
		
## Round Start Actions: Reset ball when the current_round start
func round_start():
	# NOTE: reset paddle position when round_start
	paddle.position.y = origin.position.y
	paddle_2.position.y = origin.position.y
	
	current_round += 1
	ball = preload("res://scenes/ball.tscn").instantiate()
	ball.position = origin.position
	add_child(ball)
	round_over = false
	game_over_menu.visible = false

## Round End Actions
func round_end():
	print("Round:", current_round, " p1: ", p1_score, " ,p2: ", p2_score)
	# remove_child(ball)
	if ball != null:
		ball.queue_free()
	round_over = true
	

## Signal when ball touch left side
func _on_point_area_body_entered(body: Node2D) -> void:
	if (body.name == ball.name and round_over == false):
		print("p2 player score")
		p2_score += 1
		audio_player_1.playing = true
		round_end()

## Singnal when ball touch right side
func _on_point_area_2_body_entered(body: Node2D) -> void:
	if (body.name == ball.name and round_over == false):
		print("p1 player score")
		p1_score += 1
		audio_player_1.playing = true
		round_end()

## Signal from paused reset button pressed
func _on_reset_btn_pressed() -> void:
	p1_score = 0
	p2_score = 0
	
	round_end()
	current_round = 0
	round_start()

## Signal from paused menu button
func _on_menu_btn_pressed() -> void:
	round_end()
	p1_score = 0
	p2_score = 0
	current_round = 0
	paused_menu.visible = false
	game_over_menu.visible = false
	start_menu.visible = true
	game_start = false
	get_tree().paused = false

## Signal to change the game round limit
func _change_round_limit(count: int):
	target_point += count
	target_point = clampi(target_point, 1, 10)

## Game Start Signal
func _start_game():
	print("start")
	start_menu.visible = false
	current_round = 0
	game_start = true
	round_start()

## Game Quit Signal
func _quit_game():
	print("quit")
	if OS.has_feature("web"):
		# NOTE: workaround on Web Quit, straight calling close() or window.close() will be block
		## Method 1: close window workaround
		#JavaScriptBridge.eval('window.open("about:blank", "_self");', true)
		#JavaScriptBridge.eval("window.close();", true)
		## Method 2: go to previous page
		JavaScriptBridge.eval("history.back();", true)
	else:
		get_tree().quit()
