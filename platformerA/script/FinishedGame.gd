extends CanvasLayer

var quit = false
signal quitgame

func End():
	if quit == true:
		$AnimationPlayer.play("Fading")
		


func _on_AnimationPlayer_animation_finished(anim_name):
	quit = false
	if anim_name == "Fading":
		$AnimationPlayer.play("Appearing")
		emit_signal("quitgame")


func _on_Timer_timeout():
	quit = true
