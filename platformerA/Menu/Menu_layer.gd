extends CanvasLayer


signal transitioned
signal trans

var start = false
var Stop = false

var first = false
var second = false

func transition():
	if start == true:
		$AnimationPlayer.play("Fading")
		first = true
	elif Stop == true:
		$AnimationPlayer.play("Fading")
		second = true

func _on_Menu_play():
	start = true
	

func _on_AnimationPlayer_animation_finished(anim_name):
	start = false
	Stop = false
	if anim_name == "Fading" and first == true:
		$AnimationPlayer.play("Appearing")
		emit_signal("transitioned")
	if anim_name == "Fading" and second == true:
		$AnimationPlayer.play("Appearing")
		emit_signal("trans")


func _on_Menu_tu():
	Stop = true
