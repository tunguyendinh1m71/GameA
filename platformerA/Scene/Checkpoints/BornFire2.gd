extends Area2D


func _ready():
	$Sprite.play()

func _input(event):
	if event.is_action_pressed("game_use") and len(get_overlapping_bodies()) > 0:
		PopUp()


func _process(_delta):
	if ObjectInteraction.Interact2 == true:
		Checkpoints.last_position2 = global_position
		_pophide()

func _pophide():
	ObjectInteraction.pophide = true
	
func PopUp():
	ObjectInteraction.popup2 = true

func _on_Checkpoint2_body_entered(_body):
	ObjectInteraction.label2 = true


func _on_Checkpoint2_body_exited(_body):
	ObjectInteraction.label2 = false
