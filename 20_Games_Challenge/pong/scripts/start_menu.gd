extends Panel

@onready var start_btn: Button = $startBtn
@onready var quit_btn: Button = $quitBtn
@onready var left_btn: Button = $HBoxContainer/leftBtn
@onready var right_btn: Button = $HBoxContainer/rightBtn
# @onready var round_limit_label: RichTextLabel = $HBoxContainer/roundLimitLabel
@onready var target_point_label: RichTextLabel = $HBoxContainer/targetPointLabel

var max_target_point: int
var init_target_point: int = 5
var target_point: int
var game_start: bool = false
var game_controller: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_controller = get_parent()
	max_target_point = game_controller.max_target_point
	init_target_point = game_controller.init_target_point

	# print("max_target_point ", max_target_point)
	# print("init_target_point ", init_target_point)
	target_point = init_target_point
	
	## NOTE: connect the btn signal
	left_btn.pressed.connect(game_controller._change_round_limit.bind(-1))
	right_btn.pressed.connect(game_controller._change_round_limit.bind(1))
	start_btn.pressed.connect(game_controller._start_game)
	quit_btn.pressed.connect(game_controller._quit_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	target_point = game_controller.target_point

	if target_point == 1:
		target_point_label.text = str(target_point) + " point"
	else:
		target_point_label.text = str(target_point) + " points"
