extends Node2D

#var End_scene = load("res://Scene/EndGame.tscn")
var end = false

func _ready():
	Playermanager.boss_battle = true
	
func _process(_delta):
	if Playermanager.close_game == true:
		$Area2D.monitoring = true
	if end == true:
		$Scene.GameClosed()


func _on_CanvasLayer_endgame():
	end = false
	if end == false:
		assert(get_tree().change_scene("res://Scene/EndGame.tscn") == OK)
		$Current_scene.get_child(0).queue_free()

func _on_Area2D_body_entered(_body):
	print("nya")
	end = true
