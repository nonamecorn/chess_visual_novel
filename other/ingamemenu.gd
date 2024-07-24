extends Control

@onready var select= $select
@onready var save= $save

signal continue_pressed

var player_file1 = autoload.save_file_path
var scene
var player

func innit(playernode):
	player = playernode
	show()

func _on_save_pressed():
	update_slot_information()
	select.hide()
	save.show()


func _on_continue_pressed():
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
	else:
		$save/MarginContainer/VBoxContainer/slot1/HBoxContainer/VBoxContainer/Button.text = "save?"
		$save/MarginContainer/VBoxContainer/slot1/Label2.text = "EMPTY"

func _on_button_pressed():
	var file = FileAccess.open(player_file1,FileAccess.WRITE)
	var stored_data = create_player_data()
	file.store_var(stored_data)
	$AudioStreamPlayer.play()
	update_slot_information()


func _on_back_pressed():
	select.show()
	save.hide()
