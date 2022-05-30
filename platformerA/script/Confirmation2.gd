extends CanvasLayer

var Bonfire2 = false



func _ready():
	$WindowDialog/Button_yes.grab_focus()

func _process(_delta):
	if ObjectInteraction.popup2 == true:
		$WindowDialog.visible = true
		$Press_anouncement.visible = false
		ObjectInteraction.label2 = false
		Bonfire2 = true
	if ObjectInteraction.pophide == true:
		$WindowDialog.visible = false
		Bonfire2 = false
	if ObjectInteraction.label2 == true:
		$Press_anouncement.visible = true
	else:
		$Press_anouncement.visible = false
	
func _on_Button_no_pressed():
	ObjectInteraction.pophide = true


func _on_Button_yes_pressed():
	if Bonfire2 == true:
		ObjectInteraction.Interact2 = true
		print("Nya")
