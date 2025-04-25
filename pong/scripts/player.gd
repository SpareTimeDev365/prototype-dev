extends CharacterBody2D

var node2D: Node2D
var move_speed
var key_up: Key
var key_down: Key

func _ready():
	print("test")
	node2D = get_parent()
	move_speed = node2D.move_speed
	key_up = node2D.key_up
	key_down = node2D.key_down
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if Input.is_key_pressed(key_up):
		position.y -= 1 * delta * move_speed
		# print(key_up, " key pressed")
		
	if Input.is_key_pressed(key_down):
		position.y += 1 * delta * move_speed
		# print(key_down, " key pressed")
	move_and_slide()
