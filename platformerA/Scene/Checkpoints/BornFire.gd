extends Area2D


func _ready():
	$Sprite.play()

func _input(event):
	if event.is_action_pressed("game_use") and len(get_overlapping_bodies()) > 0:
		_popup()


func _process(_delta):
	if ObjectInteraction.Interact == true:
		Checkpoints.last_position = global_position
		_pophide()
	
func _pophide():
	ObjectInteraction.pophide = true

func _popup():
	ObjectInteraction.popup = true


func _on_Checkpoint_body_entered(_body):
	ObjectInteraction.label = true


func _on_Checkpoint_body_exited(_body):
	ObjectInteraction.label = false
