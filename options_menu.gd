extends CanvasLayer

@export
var time_to_fade := 0.333


func _ready():
	visible = false
	$ColorRect.modulate = Color.TRANSPARENT
	if OS.has_feature("web"): %exit.visible = false
	var bb = load("res://blackboard.tres")
	if not bb: return
	if not "options_screens" in bb: return
	for screen in bb.options_screens:
		var s = screen.instantiate()
		%TabContainer.add_child(s)

var pause_cache = false
var mode_cache
func FadeIn(title:= false):
	var tree = get_tree()
	if has_node("/root/_IMP"):
		mode_cache = _IMP.mode
		_IMP.mode = _IMP.TRANSITION
	pause_cache = tree.paused
	tree.paused = true
	visible = true
	%title.visible = not title
	var tween = tree.create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($ColorRect, "modulate", Color.WHITE, time_to_fade)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	if has_node("/root/_IMP"): _IMP.mode = _IMP.MENU
	%return.grab_focus()
		
signal finished
func FadeOut():
	if has_node("/root/_IMP"):
		_IMP.mode = _IMP.TRANSITION
	var tree = get_tree()
	var tween = tree.create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($ColorRect, "modulate", Color.TRANSPARENT, time_to_fade)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	visible = false
	tree.paused = pause_cache
	if has_node("/root/_IMP"): _IMP.mode = mode_cache
	finished.emit()
		
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var t = get_tree()
		await t.process_frame
		await t.process_frame
		t.quit()



func _on_return_pressed():
	if has_node("/root/_IMP"):
		if _IMP.mode != _IMP.MENU: return
	FadeOut()

func _on_title_pressed():
	if has_node("/root/_IMP"):
		if _IMP.mode != _IMP.MENU: return
	FadeOut()
	await finished
	_FADE.FadeTo("res://addons/hd-ui/hd-title.tscn")

func _on_exit_pressed():
	if has_node("/root/_IMP"):
		if _IMP.mode != _IMP.MENU: return
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
