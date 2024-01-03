extends Area2D

var direction = Vector2(1,0)
var speed = 300
var velocity: = Vector2()
var half_of_tile_size = 4

const RAY_LENGTH = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",_collide)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speed * direction * delta

func _collide(body):
	print("Collide: ",body.name, " : ", self.get_parent().name)
	
	if (body.name.find("mob") != -1 and body['health'] != null):
		body.health -= 10
	
	if (body.name != self.get_parent().name):
		queue_free()
		
