extends CanvasLayer

signal change
var Change_scene = false

func _tra():
	if Change_scene == true:
		$AnimationPlayer.play("Fade")
		

func _on_AnimationPlayer_animation_finished(anim_name):
	Change_scene = false
	if anim_name == "Fade":
		$AnimationPlayer.play("appear")
		emit_signal("change")


func _on_Button_pressed():
	Change_scene = true
