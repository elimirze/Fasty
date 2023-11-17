extends Button

func _on_button_down():
	get_tree().change_scene_to_file("res://Scenes/Adjustment.tscn")

func _ready():
	if Global.audio==false:
		%CheckBox.button_pressed=true
		AudioServer.set_bus_mute(0, true)
		%CheckBox.button_pressed=true
	else:
		%CheckBox.button_pressed=false
		AudioServer.set_bus_mute(0, false)
		%CheckBox.button_pressed=false

func _on_check_box_toggled(button_press):
	if button_press==true:
		AudioServer.set_bus_mute(0, true)
		%CheckBox.set_button_icon(preload("res://Sprites/music off.png"))
		Global.audio=false
	else:
		AudioServer.set_bus_mute(0, false)
		%CheckBox.set_button_icon(preload("res://Sprites/music on.png"))
		Global.audio=true
