extends Control

func _ready():
	Playermanager.gui=self
	
func set_bar_value(value_to_set: float):
	$TextureProgress.value = value_to_set
	if value_to_set == 0:
		Playermanager.player._die()
