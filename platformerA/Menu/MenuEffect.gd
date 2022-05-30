extends Control


signal play
signal tu

var something = false
var tuto = false
onready var Scene = preload("res://Scene/level/world1.tscn")
onready var Tutorial = preload("res://Scene/Tutorial.tscn")
onready var Settings_menu = $SettingsMenu

func _ready():
	$Button_system/StartButton.grab_focus()
	$Button_system.visible = true
	$AudioStreamPlayer.play()

func _on_StartButton_pressed():
	something = true
	emit_signal("play")

func _on_SettingButton_pressed():
	Settings_menu.popup_centered()


func _on_ExitButton_pressed():
	get_tree().quit()
	
func _process(_delta):
	if something == true:
		$CanvasLayer.transition()
	elif tuto == true:
		$CanvasLayer.transition()

func _on_CanvasLayer_transitioned():
	$Current_scene.get_child(0).queue_free()
	$Current_scene.add_child(Scene.instance())
	$Current_scene/Sprite.queue_free()
	$Current_scene/Label.queue_free()
	


func _on_TutorialButton_pressed():
	tuto = true
	emit_signal("tu")


func _on_CanvasLayer_trans():
	$Current_scene.add_child(Tutorial.instance())
	$Current_scene.get_child(0).queue_free()
	$Current_scene/Sprite.queue_free()
	$Current_scene/Label.queue_free()
