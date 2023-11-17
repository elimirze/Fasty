extends Node2D
var rand_fig=0
var score=10
var total_score=0
var speedifier=1
var speed_rate=0.1
var max_time=5
var time=0
var cube_added=false
func _ready():
	max_time=Global.max_time
	speedifier=Global.speedifier
	speed_rate=Global.speed_rate
	time=max_time
	$CanvasLayer/Control/MarginContainer/VBoxContainer/ProgressBar.max_value=max_time
func _process(delta):
	
	$CanvasLayer/Control/MarginContainer/VBoxContainer/ProgressBar.value=time
	$CanvasLayer/Control/MarginContainer/VBoxContainer/Label.text=str(total_score)
	if time>0:
		time-=delta*speedifier
		if cube_added==false:
			var gameobject=null
			rand_fig=randi_range(0,5)
			match rand_fig:
				0:
					gameobject=preload("res://Scenes/cloud.tscn").instantiate()
				1:
					gameobject=preload("res://Scenes/cube.tscn").instantiate()
				2:
					gameobject=preload("res://Scenes/hexagon.tscn").instantiate()
				3:
					gameobject=preload("res://Scenes/pentagon.tscn").instantiate()
				4:
					gameobject=preload("res://Scenes/star.tscn").instantiate()
				5:
					gameobject=preload("res://Scenes/triangle.tscn").instantiate()
			gameobject.modulate=Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),1)
			while gameobject.dir==0:
				gameobject.dir=randi_range(-1,1)
			var rand_scale=randf_range(0.02,0.1)
			gameobject.scale=Vector2(rand_scale,rand_scale)
			gameobject.speed=randf_range(50,300)
			var offset=512*gameobject.scale/2
			var clamp_left=$Camera2D.position.x-get_viewport_rect().size.x/2+offset.x
			var clamp_right=$Camera2D.position.x+get_viewport_rect().size.x/2-offset.x
			var clamp_up=$Camera2D.position.y-get_viewport_rect().size.y/2+offset.y
			var clamp_down=$Camera2D.position.y+get_viewport_rect().size.y/2-offset.y
			gameobject.position=Vector2(randf()*randf_range(-1000,1000),randf()*randf_range(-1000,1000)) 
			gameobject.position.x=clamp(gameobject.position.x,clamp_left,clamp_right)
			gameobject.position.y=clamp(gameobject.position.y,clamp_up,clamp_down)
			get_tree().get_root().add_child(gameobject)
			time=max_time
			cube_added=true
	else:
		Global.score=total_score
		get_tree().change_scene_to_file("res://Scenes/LoseScreen.tscn")
		time=0
	
