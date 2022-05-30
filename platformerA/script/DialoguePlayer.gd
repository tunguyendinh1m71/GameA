extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = [] 
var current_dialogue_id = -1
var is_dialgogue_ative = false


func _ready( ):
	$NinePatchRect.visible = false
	$NinePatchRect/Indicator/AnimationPlayer.play("MOve")
	
	
func _process(_delta):
	if ObjectInteraction.label1 == true:
		$Press_suggestion.visible = true
	else:
		$Press_suggestion.visible = false
	
func play():
	if is_dialgogue_ative:
		return
	
	dialogues = load_dialogue()
	
	ObjectInteraction.label1 = false
	is_dialgogue_ative = false
	$NinePatchRect.visible = true
	next_line()
	
func _input(event):
	if not is_dialgogue_ative:
		return
	
	if event.is_action_pressed("game_use"):
		next_line()
		
func next_line():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogues):
		is_dialgogue_ative = false
		$NinePatchRect.visible = false
		current_dialogue_id = -1
		return
	
	$NinePatchRect/Name.text = dialogues[current_dialogue_id]["name"]
	$NinePatchRect/Message.text = dialogues[current_dialogue_id]["text"]
	$NinePatchRect/Indicator/AnimationPlayer.play("Word_spread")
	
	
func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file. READ)
		return parse_json(file.get_as_text())
