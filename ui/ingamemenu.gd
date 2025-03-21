extends Control

@onready var select= $select
@onready var save= $save
@onready var loadwin = $load

signal continue_pressed

var player_file1 = autoload.save_file_path
var scene
var player

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if !visible and get_tree().paused:
			return
		get_tree().paused = !get_tree().paused
		visible = !visible

func _on_save_pressed():
	update_slot_information()
	select.hide()
	save.show()

func _on_load_pressed():
	update_slot_information()
	select.hide()
	loadwin.show()

func _on_continue_pressed():
	get_tree().paused = !get_tree().paused
	hide()
	emit_signal("continue_pressed")

func create_player_data():
	var data = {
		"progress": autoload.progress,
		"saved_scene": autoload.saved_scene,
		"playerhp": autoload.playerhp,
		"cardpaths": [],
		}
	return data


func update_slot_information():
#	var file = FileAccess.open(player_file1, FileAccess.READ)
	if FileAccess.file_exists(player_file1):
		$save/MarginContainer/VBoxContainer/slot1/Label2.text = "SAVE STORED"
		$save/MarginContainer/VBoxContainer/slot1/HBoxContainer/VBoxContainer/Button.text = "reset?"
		
		$load/MarginContainer/VBoxContainer/slot1/Label2.text = "SAVE STORED"
		$load/MarginContainer/VBoxContainer/slot1/HBoxContainer/VBoxContainer/load.text = "load?"
	else:
		$save/MarginContainer/VBoxContainer/slot1/HBoxContainer/VBoxContainer/Button.text = "save?"
		$save/MarginContainer/VBoxContainer/slot1/Label2.text = "EMPTY"
		
		$load/MarginContainer/VBoxContainer/slot1/HBoxContainer/VBoxContainer/load.text = ""
		$load/MarginContainer/VBoxContainer/slot1/Label2.text = "EMPTY"

func _on_load_slot_pressed():
	if FileAccess.file_exists("user://slot1.dat"):
		var file = FileAccess.open("user://slot1.dat", FileAccess.READ)
		var loaded_data = file.get_var()
#		print(loaded_data)
		autoload.progress = loaded_data.progress
		autoload.saved_player_position = loaded_data.saved_player_position
		autoload.saved_scene = loaded_data.saved_scene
		autoload.playerhp = loaded_data.playerhp
		autoload.enemylistbiome1 = loaded_data.enemylistbiome1
		autoload.save_file_path = "user://slot1.dat"
		get_tree().change_scene_to_file(autoload.saved_scene)

func _on_load_back_pressed():
	select.show()
	loadwin.hide()


func _on_back_pressed():
	select.show()
	save.hide()
