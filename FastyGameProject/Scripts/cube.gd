extends CharacterBody2D
var dir=0
var speed=100
func _process(delta):
	if rotation_degrees>360:
		rotation_degrees=-360
	elif rotation_degrees<-360:
		rotation_degrees=360
	else:
		rotation_degrees+=delta*speed*dir
	



func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		var objects=get_tree().get_nodes_in_group("game")
		objects[0].speedifier+=objects[0].speed_rate
		objects[0].total_score+=int(objects[0].score*(objects[0].time/objects[0].max_time))
		objects[0].cube_added=false
		queue_free()
