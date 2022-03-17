extends Control



func _ready():
	pass # Replace with function body.

func _process(delta):
	if $StaminaBar.value <= 100:
		$StaminaBar.value += 4*delta
