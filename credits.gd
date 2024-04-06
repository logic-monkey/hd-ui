extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	%return.grab_focus()
	var bb = load("res://blackboard.tres")
	if not bb: return
	if "audioCredits" in bb: 
		for credit in bb.audioCredits:
			var l = Label.new()
			l.text = credit
			l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			%music_creds.add_child(l)
	if "_data" in bb and "title" in bb._data:
		%game_name.text = bb._data.title



func _on_return_pressed():
	_FADE.FadeTo("res://addons/hd-ui/hd-title.tscn")
