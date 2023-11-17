extends Label
var score=0

func _ready():
	score=Global.score
	text="Total Score: "+str(score)


func _on_retry_button_down():
	Global.score=0
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_main_menu_button_down():
	Global.score=0
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_adjust_button_down():
	Global.score=0
	get_tree().change_scene_to_file("res://Scenes/Adjustment.tscn")
