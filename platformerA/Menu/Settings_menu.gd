extends Popup

#Video settings
onready var display_options = $SettingsTabs/Video/MarginContainer/VideoSettings/DisplayOptionsBtn
onready var Vsync_btn = $SettingsTabs/Video/MarginContainer/VideoSettings/VsyncBtn
onready var Display_fps_btn = $SettingsTabs/Video/MarginContainer/VideoSettings/DisplayFpsBtn
onready var Max_fps_val = $SettingsTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsVal
onready var Max_fps_slider = $SettingsTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsSlider
onready var Bloom_btn = $SettingsTabs/Video/MarginContainer/VideoSettings/BloomBtn

#Audio settings
onready var Volume_slider = $SettingsTabs/Audio/MarginContainer/AudioSettings/VolSlider
onready var Music_slider = $SettingsTabs/Audio/MarginContainer/AudioSettings/MusicVolSlider
onready var Sfx_volume_slider = $SettingsTabs/Audio/MarginContainer/AudioSettings/SfxVolSlider

func _ready():
	pass


func _on_DisplayOptionsBtn_item_selected(index):
	GlobalSettings.toggle_fullscreen(true if index == 1 else false)
	

func _on_VsyncBtn_toggled(button_pressed):
	GlobalSettings.toggle_vsync(button_pressed) 


func _on_DisplayFpsBtn_toggled(button_pressed):
	GlobalSettings.toggle_fps_display(button_pressed)


func _on_MaxFpsSlider_value_changed(value):
	GlobalSettings.set_max_fps(value)
	Max_fps_val.text = str(value) if value < Max_fps_slider.max_value else "max"

func _on_BloomBtn_toggled(button_pressed):
	GlobalSettings.toggle_bloom(button_pressed)


func _on_VolSlider_value_changed(value):
	GlobalSettings.update_volume(value)


func _on_MusicVolSlider_value_changed(value):
	GlobalSettings.update_music(value)

func _on_SfxVolSlider_value_changed(value):
	GlobalSettings.update_sfx(value)
