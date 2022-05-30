extends Control

var appear = false
var menu_scene = load("res://Menu/Menu.tscn")

func _ready():
	$Timer.start()

func _process(_delta):
	if appear == true:
		$CanvasLayer.End()


func _on_CanvasLayer_quitgame():
	appear = false
	$Node2D.add_child(menu_scene.instance())
	$Node2D.get_child(0).queue_free()
	$VBoxContainer.queue_free()
	$ColorRect.queue_free()
	


func _on_Timer_timeout():
	appear = true

	
