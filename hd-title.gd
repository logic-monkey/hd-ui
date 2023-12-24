extends CanvasLayer


func _ready():
	if OS.has_feature("web"):
		%exit.visible = false
	load_data()
	%start.grab_focus()
		
func load_data():
	var bb = load("res://blackboard.tres")
	if not bb: return
	if "notes" in bb:
		%notes.text = bb.notes
	if "title_theme" in bb and has_node("/root/_MUSIC"):
		_MUSIC.SwitchToSong(bb.title_theme)
		
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var t = get_tree()
		await t.process_frame
		await t.process_frame
		t.quit()


func _on_exit_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)


func _on_options_pressed():
	if not has_node("/root/_OPT"): return
	_OPT.FadeIn(true)
	await _OPT.finished
	%options.grab_focus()


func _on_credits_pressed():
	_FADE.FadeTo("res://addons/hd-ui/credits.tscn")
