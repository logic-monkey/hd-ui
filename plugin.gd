@tool
extends EditorPlugin

const NAME = "_OPT"
#const UI = "_UI"

func _enter_tree():
	add_autoload_singleton(NAME, "res://addons/hd-ui/options_menu.tscn")
	#add_autoload_singleton(UI, "res://addons/hd-ui/hd_ui.tscn")
	pass

func _exit_tree():
	remove_autoload_singleton(NAME)
	#remove_autoload_singleton(UI)
	pass
