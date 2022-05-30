extends CanvasLayer


signal transitioned
var change_scene = false

func ChangeScene():
	if change_scene == true:
		$AnimationPlayer.play("Fade")
		
	

func _on_AnimationPlayer_animation_finished(anim_name):
	change_scene = false
	if anim_name == "Fade":
		$AnimationPlayer.play("illuminate")
		emit_signal("transitioned")


func _on_Area2D_body_entered(_body):
#	if body.name == "Player2":
		change_scene = true
