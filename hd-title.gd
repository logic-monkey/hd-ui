extends CanvasLayer

func _ready():
	if OS.has_feature("web"):
		%exit.visible = false
	load_data()
	%start.grab_focus()
	#await get_tree().create_timer(1).timeout
	#_IMP.mode = 
		
var bg = null
func load_data():
	var bb = load("res://blackboard.tres")
	if not bb: return
	if "notes" in bb:
		%notes.text = bb.notes
	if "title_theme" in bb and has_node("/root/_MUSIC"):
		_MUSIC.SwitchToSong(bb.title_theme)

	if "title" in bb:
		%title.text = bb.title
	if "story" in bb and bb.story:
		%story.visible = true
		if "story_only" in bb and bb.story_only:
			%start.visible = false
	if "title_background" in bb and bb.title_background:
		bg = load(bb.title_background).instantiate()
		%background.add_child(bg)
	if "_data" in bb:
		if "title" in bb._data:
			%title.text = bb._data.title
		if "title_background" in bb._data:
			bg = load(bb._data.title_background).instantiate()
			%background.add_child(bg)
		
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


func _on_start_pressed():
	var bb = load("res://blackboard.tres")
	if not bb or not "_data" in bb or not "start_target" in bb._data: 
		print_rich("[pulse][b][color=#6699ff]Pressed Start; No 'start_target' in blackboard.[/color][/b][/pulse]")
		return
	_FADE.FadeTo(bb._data.start_target)


func _on_story_pressed() -> void:
	if bg and bg.has_method("start"):
		bg.start()
		await bg.started
	#_PANELS.Start()
