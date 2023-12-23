extends Node

var sceneIndex = 0
var currentScene = null
var main
var sceneNames = [
	"RigidScene",
	"Pointer",
	"Peer",
	"Platformer"
]
var scenes = []
func _init():
	for sn in sceneNames:
		scenes.append({Src = "res://scenes/"+sn+".tscn", Name = sn, Scene = null})
# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().root
	for src in scenes:
		src.Scene = load(src.Src)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sceneIndex = (0 if sceneIndex+1 >= scenes.size() else sceneIndex + 1) if Input.is_action_just_pressed("ChangeScene") else sceneIndex
	if (currentScene == null or not scenes[sceneIndex].Name.contains(currentScene.name)):
		if (currentScene != null):
			main.remove_child(currentScene)
			currentScene = null
		currentScene = scenes[sceneIndex].Scene.instantiate()
		main.add_child(currentScene)
		currentScene.name = scenes[sceneIndex].Name
