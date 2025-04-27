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

func _draw() -> void:
	draw_circle(Vector2.ZERO, circle_radius, circle_color)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()
	init_rotation = 0.0
	force = Vector2(-ball_speed, -ball_speed)
	apply_central_force(force)
	# pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	pass
	# rotation = init_rotation


func _on_body_entered(body: Node) -> void:
	print(body.name)
	var name = body.name
	if (name == paddle1.name or name == paddle2.name):
		force.x = -1 * force.x
	elif (name == top.name or name == bottom.name):
		force.y = -1 * force.y
		
	apply_central_force(force)
