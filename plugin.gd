@tool
extends EditorPlugin

const NAME = "_OPT"

func _enter_tree():
	add_autoload_singleton(NAME, "res://addons/hd-ui/options_menu.tscn")
	pass

func _exit_tree():
	remove_autoload_singleton(NAME)
	pass
