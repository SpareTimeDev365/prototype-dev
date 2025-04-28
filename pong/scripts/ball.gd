extends RigidBody2D

@export var ball_speed: int
@export var paddle1: StaticBody2D
@export var paddle2: StaticBody2D
@export var top: StaticBody2D
@export var bottom: StaticBody2D

var init_rotation: float
var circle_color: Color = Color(0.0, 1.0, 0.0)
var circle_radius: float = 25.0
var force := Vector2(0, 0)
var direction = Vector2(5, 5).normalized()

func _draw() -> void:
	draw_circle(Vector2.ZERO, circle_radius, circle_color)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	#print("force: ", force)
# 	pass

func _physics_process(delta):
	linear_velocity = direction * ball_speed
	pass
	
# normal reflection of ball
func _on_body_entered(body: Node) -> void:
	print(body.name)
	var node_name = body.name
	if node_name == paddle1.name or node_name == paddle2.name:
		direction = Vector2(-direction.x, direction.y)
	elif node_name == top.name or node_name == bottom.name:
		direction = Vector2(direction.x, -direction.y)
