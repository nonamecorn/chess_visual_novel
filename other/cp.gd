extends Node

signal change_scene
signal engage
signal save

func process(command, arguments):
	match command:
		"change_scene":
			emit_signal("change_scene", arguments[0])
		"engage":
			emit_signal("engage", arguments[0], arguments[1])
		"save":
			emit_signal("save")
