extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0
var doubleJump = false
var sideJump = false # PARKOUR
var lastDir = 0
@onready var cam = $".Camera2D"

var edelta = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _enter_tree():
	set_multiplayer_authority(name.to_int())
	if cam == null:
		cam = $Camera2D
	cam.enabled = is_multiplayer_authority()
	
func _physics_process(delta):
	edelta = delta
	if is_multiplayer_authority():
		movement(delta)
		actions(delta)

func actions(delta):
	if Input.is_action_just_pressed("exit"):
		$"../".exit_game(name)

func movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif not doubleJump:
			doubleJump = true
			velocity.y = JUMP_VELOCITY
			velocity.x /= 1.5
			if is_on_wall():
				velocity.x = lastDir * SPEED * -1
			

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor():
		doubleJump = false
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			lastDir = direction
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()



#https://www.youtube.com/watch?v=Dvnjdeam634
@rpc("unreliable","any_peer","call_local") func updatePos(id,pos):
		if !is_multiplayer_authority():
			if name == id:
				position = lerp(position,pos,edelta * 15)
				
func _on_timer_timeout():
	if is_multiplayer_authority():
		rpc("updatePos",name,position)
