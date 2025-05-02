extends Panel

@onready var start_btn: Button = $startBtn
@onready var quit_btn: Button = $quitBtn
@onready var left_btn: Button = $HBoxContainer/leftBtn
@onready var right_btn: Button = $HBoxContainer/rightBtn
@onready var round_limit_label: RichTextLabel = $HBoxContainer/roundLimitLabel

var max_round_limit: int
var init_round_limit: int = 5
var round_limit: int
var game_start: bool = false
var game_controller: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_controller = get_parent()
	max_round_limit = game_controller.max_round_limit
	init_round_limit = game_controller.init_round_limit

	# print("max_round_limit ", max_round_limit)
	# print("init_round_limit ", init_round_limit)
	round_limit = init_round_limit
	
	## NOTE: connect the btn signal
	left_btn.pressed.connect(game_controller._change_round_limit.bind(-1))
	right_btn.pressed.connect(game_controller._change_round_limit.bind(1))
	start_btn.pressed.connect(game_controller._start_game)
	quit_btn.pressed.connect(game_controller._quit_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	round_limit = game_controller.round_limit
	round_limit_label.text = str(round_limit) + " round"
