extends RigidBody2D

@export var speed = 200
@export var health = 100
var vel = Vector2()
var ofs = Vector2()
var target


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_UI(delta)
	
	if (health <= 0):
		queue_free()
		
	if (target == null):
		target = %Player
	else:
		move(delta)
		
func move(delta):
	var dir = target.global_position - global_position + ofs
	vel = (dir.normalized()/25 + vel.normalized())* speed * delta
	var collide = move_and_collide(vel)
	
	
func update_UI(delta):
	$Healthbar.scale.x = lerpf($Healthbar.scale.x, 10 * health/100,delta*10)


func _on_dodge_timeout():
	ofs = Vector2(randi() * 1, randi() * 1)
	$dodge.wait_time = randi_range(5,15)/10
