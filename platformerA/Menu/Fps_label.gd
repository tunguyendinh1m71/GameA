extends Label

func _ready():
# warning-ignore:return_value_discarded
	GlobalSettings.connect("Fps_displayed", self, "_on_fps_displayed")
	
func _process(_delta):
	text = "Fps: %s" % [Engine.get_frames_per_second()] 
	
	
func _on_fps_displayed(value):
	visible = value
