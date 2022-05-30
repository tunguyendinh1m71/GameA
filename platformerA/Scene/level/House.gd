extends Node

var scene_changed = false

var Scene = load("res://Scene/BossBattles/BossMatch.tscn")

func _enter_tree():
	if Checkpoints.last_position:
		$PLayers/Player2.global_position = Checkpoints.last_position
	if Checkpoints.last_position2:
		$PLayers/Player2.global_position = Checkpoints.last_position2

	
	
func _process(_delta):
	if scene_changed == true:
		$CanvasLayer.ChangeScene()


func _on_CanvasLayer_transitioned():
	scene_changed = false
	Playermanager.boss_battle = true
	$Node2D.add_child(Scene.instance())
	$Area2D.queue_free()
	$enemies.queue_free()
	$Bonfires.queue_free()
	$Tilesmap.queue_free()
	$Stores.queue_free()
	$Background.queue_free()


func _on_Area2D_body_entered(_body):
#	if body.name == "Player2":
		scene_changed = true
