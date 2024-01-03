extends Node2D



func _on_timer_timeout():
	var mobs = get_children().size()
	if (mobs < 5):
		print("Neh Mob")
		var mob = load("res://scenes/mob.tscn").instantiate()
		add_child(mob)
		mob.name = "mob"
		mob.target = %Player
