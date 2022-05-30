extends CanvasLayer


var Bonfire = false



func _ready():
	$WindowDialog/Button_yes.grab_focus()

func _process(_delta):
	if ObjectInteraction.popup == true:
		$WindowDialog.visible = true
		$Press_anouncement.visible = false
		ObjectInteraction.label = false
		Bonfire = true
	if ObjectInteraction.pophide == true:
		$WindowDialog.visible = false
		Bonfire = false
	if ObjectInteraction.label == true:
		$Press_anouncement.visible = true
	else:
		$Press_anouncement.visible = false
	
func _on_Button_no_pressed():
	ObjectInteraction.pophide = true


func _on_Button_yes_pressed():
	if Bonfire == true:
		ObjectInteraction.Interact = true
		print("yamete")
