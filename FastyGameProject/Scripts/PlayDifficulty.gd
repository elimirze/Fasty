extends TextureRect

func _ready():
	$MarginContainer/VBoxContainer/MaxTime/MaxTime.value=Global.max_time
	$MarginContainer/VBoxContainer/MaxTime/Label2.text=str(Global.max_time)
	$MarginContainer/VBoxContainer/Speed/Speed.value=Global.speedifier
	$MarginContainer/VBoxContainer/Speed/Label2.text=str(Global.speedifier)
	$MarginContainer/VBoxContainer/SpeedRate/SpeedRate.value=Global.speed_rate
	$MarginContainer/VBoxContainer/SpeedRate/Label2.text=str(Global.speed_rate)
	
func _process(_delta):
	Global.max_time=$MarginContainer/VBoxContainer/MaxTime/MaxTime.value
	$MarginContainer/VBoxContainer/MaxTime/Label2.text=str($MarginContainer/VBoxContainer/MaxTime/MaxTime.value)
	Global.speedifier=$MarginContainer/VBoxContainer/Speed/Speed.value
	$MarginContainer/VBoxContainer/Speed/Label2.text=str($MarginContainer/VBoxContainer/Speed/Speed.value)
	Global.speed_rate=$MarginContainer/VBoxContainer/SpeedRate/SpeedRate.value
	$MarginContainer/VBoxContainer/SpeedRate/Label2.text=str($MarginContainer/VBoxContainer/SpeedRate/SpeedRate.value)
	

func _on_play_button_down():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_back_pressed():
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
