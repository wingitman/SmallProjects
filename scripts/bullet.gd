extends Area2D

var direction = Vector2(1,0)
var speed = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",_collide)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speed * direction * delta

func _collide(body):
	print("Collide: ",body.name)
