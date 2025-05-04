extends RigidBody2D

@export var ball_speed: int

@onready var paddle_1: StaticBody2D = $'../paddle'
@onready var paddle_2: StaticBody2D = $'../paddle2'
@onready var top: StaticBody2D = $'../top'
@onready var bottom: StaticBody2D = $'../bottom'
@onready var audio_player_2: AudioStreamPlayer2D = $AudioPlayer2


var circle_color: Color = Color(0.0, 1.0, 0.0)
var circle_radius: float = 25.0
var direction
var bounce_count: int

func _draw() -> void:
	draw_circle(Vector2.ZERO, circle_radius, circle_color)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()
	bounce_count = 0
	print("ball ready")
	## NOTE: ternary condition in GDScript, decided left or right
	var direction_x: float = 1.0 if (randi() % 2 == 0) else -1.0
	direction = Vector2(direction_x, randfn(0.3, 1.0)).normalized()

func _physics_process(delta):
	linear_velocity = direction * ball_speed
	
## normal reflection of ball
func _on_body_entered(body: Node) -> void:
	bounce_count += 1
	# NOTE: accelerate ball speed to prevent draw
	if bounce_count % 5 == 0 and bounce_count > 0:
		direction *= 1.2
	
	if audio_player_2:
		audio_player_2.playing = true
		
	print(body.name)
	var node_name = body.name
	if node_name == paddle_1.name or node_name == paddle_2.name:
		direction = Vector2(-direction.x, direction.y)
	elif node_name == top.name or node_name == bottom.name:
		direction = Vector2(direction.x, -direction.y)
