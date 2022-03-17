extends Control


signal play

var something = false
onready var Scene = preload("res://Scene/level/world1.tscn")

func _ready():
	$Button_system/StartButton.grab_focus()

func _on_StartButton_pressed():
	something = true
	emit_signal("play")

func _on_SettingButton_pressed():
	pass


func _on_ExitButton_pressed():
	get_tree().quit()
	
func _process(_delta):
	if something == true:
		$Menu_layer.transition()


func _on_Menu_layer_transitioned():
	$Current_scene.get_child(0).queue_free()
	$Current_scene.add_child(Scene.instance())
	


func _on_Menu_layer_ended():
	pass
