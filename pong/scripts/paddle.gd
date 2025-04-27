extends StaticBody2D

@export var move_speed: int
@export var key_up: Key
@export var key_down: Key

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(key_up):
		position.y -= move_speed * delta
		
	if Input.is_key_pressed(key_down):
		position.y += move_speed * delta
	pass
