extends ParallaxLayer


var invisible = true

export(float) var CLOUD_SPEED = -40

func _process(delta) -> void:
	self.motion_offset.x += CLOUD_SPEED * delta


