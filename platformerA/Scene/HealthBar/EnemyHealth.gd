extends Control

func _ready():
	Playermanager.gui_1=self
	Playermanager.gui_1A = self
	
func set_new_health(value: float):
	$ProgressBar.value = value

func reset_new_health(value: float):
	$ProgressBar.value = value

