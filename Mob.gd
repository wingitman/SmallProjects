extends RigidBody2D

@export var speed = 250
@export var health = 100
var vel = Vector2()
var ofs = Vector2()
var target


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_UI(delta)
		
	if (target == null):
		target = %Player
		if (target == null):
			target = get_parent().get_parent().find_child("Player",true)#get_tree().root.get_child("Player")
			print("Eh? ", target)
	else:
		move(delta)
	
	if (health <= 0):
		queue_free()
		
func move(delta):
	var dir = target.global_position - global_position + ofs
	vel = (dir.normalized()/50 + vel.normalized())* speed * delta
	var collide = move_and_collide(vel)
	
	
func update_UI(delta):
	$Healthbar.scale.x = lerpf($Healthbar.scale.x, 10 * health/100,delta*10)


func _on_dodge_timeout():
	ofs = Vector2(randi_range(-100,100),randi_range(-100,100))
	$dodge.wait_time = randi_range(5,30)/10
