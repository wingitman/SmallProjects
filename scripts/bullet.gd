extends Area2D

var direction = Vector2(1,0)
var speed = 300
var bounces = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",_collide)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speed * direction * delta

func _collide(body):
	print("Collide: ",body.name, " : ", self.get_parent().name)
	if (body.name != self.get_parent().name) and bounces <= 0:
		queue_free()
	else:
		var incidence = global_rotation - body.global_rotation
		# Calculate the angle of reflection
		var reflection = incidence
		# Calculate the reflected rotation angle
		var reflected_rotation = global_rotation - incidence + reflection
		# Set the rotation of the reflected laser
		global_rotation = reflected_rotation
