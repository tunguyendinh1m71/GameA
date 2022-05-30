extends CanvasLayer

signal endgame
var close = false

func GameClosed():
	
	if close == true:
		$AnimationPlayer.play("Dark")
		

func _on_AnimationPlayer_animation_finished(anim_name):
	close = false
	if anim_name == "Dark":
		$AnimationPlayer.play("Bright")
		emit_signal("endgame")


func _on_Area2D_body_entered(_body):
	close = true
