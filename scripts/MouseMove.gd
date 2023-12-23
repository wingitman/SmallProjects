extends RigidBody2D

const MAX_SPEED = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = get_global_mouse_position() - global_position
	var speed = dir.length() if dir.length() < MAX_SPEED else MAX_SPEED
	linear_velocity = dir.normalized() * speed*speed
	linear_velocity = linear_velocity if linear_velocity.length() < MAX_SPEED else linear_velocity.normalized() * MAX_SPEED
