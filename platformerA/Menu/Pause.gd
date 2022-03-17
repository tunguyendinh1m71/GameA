extends CanvasLayer



func _ready():
	$VBoxContainer/Continue.grab_focus()
	set_visible(false)
	$Background.visible = false
	
func _input(event):
	
	if event.is_action_pressed("ui_cancel"): # escape button by default
		set_visible(!get_tree().paused) # if not pause then hide
		get_tree().paused = !get_tree().paused # toggle pause status


func _on_Continue_pressed():
	get_tree().paused = false
	set_visible(false)
	
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible


func _on_Setting_pressed():
	pass


func _on_Menu_pressed():
	var _Menu
	_Menu = get_tree().change_scene("res://Menu/Menu.tscn")
	
func _on_Quit_pressed():
	get_tree().quit()
	
