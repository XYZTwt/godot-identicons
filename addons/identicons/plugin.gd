@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Identicon","Node2D",preload("identicon.gd"),preload("icon.svg"))

func _exit_tree():
	remove_custom_type("Identicon")
