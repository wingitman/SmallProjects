extends RigidBody2D

var marker2d
var canShoot = true
# Called when the node enters the scene tree for the first time.
func _ready():
	marker2d = $"Marker2D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var move = Vector2(Input.get_axis("ui_left","ui_right"),Input.get_axis("ui_up","ui_down"))
	move_and_collide(move * 100 * delta)
	
	var pos = global_position
	var mpos = get_global_mouse_position()
	var rot = pos.angle_to_point(mpos)
	rotation = rot
	
	var dist = (pos-mpos).length()
	dist = dist if dist < 50 else 50
	marker2d.position.x = dist/2
	
	if Input.is_action_pressed("Action") and canShoot:
		fire(marker2d.global_position,rot)
		canShoot = false
		$Shoot.start()

func fire(from,angle):
	var direction = Vector2(1,0).rotated(angle).normalized()
	var bullet = load("res://scenes/bullet.tscn").instantiate()
	bullet.direction = direction
	bullet.global_position = from
	bullet.rotation = angle
	bullet.scale *= 10
	get_parent().add_child(bullet)


func _on_shoot_timeout():
	canShoot = true
