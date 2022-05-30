extends Control

var back = false
var Menu = load("res://Menu/Menu.tscn")

func _ready():
	$Back_button/Button.grab_focus()
	$Movement/Button_down.visible = true
	$Movement/Button_left.visible = true
	$Movement/Button_right.visible = true
	$Movement/Button_up.visible = true
	$VBoxContainer.visible = true
	$VBoxContainer2.visible = true
	
func _process(_delta):
	if back == true:
		$CanvasLayer._tra()
		


func _on_CanvasLayer_change():
	back = false
	$Node2D.add_child(Menu.instance())
	$Node2D.get_child(0).queue_free()
	$TextureRect.queue_free()


func _on_Button_pressed():
	back = true
