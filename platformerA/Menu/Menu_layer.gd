extends CanvasLayer


signal transitioned
signal ended

var start = false
var Stop = false

func transition():
	if start == true:
		$AnimationPlayer.play("Fading")


func _on_Menu_play():
	start = true
	

func _on_AnimationPlayer_animation_finished(anim_name):
	start = false
	if anim_name == "Fading":
		$AnimationPlayer.play("Appearing")
		emit_signal("transitioned")

func _stop():
	Stop = true
	if Stop == true:
		emit_signal("ended")
