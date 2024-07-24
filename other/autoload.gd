extends Node

var save_file_path = "user://slot1.dat"
var progress = 0
var current_enemy_index
var saved_player_position = Vector2.ZERO
var current_player_position = Vector2.ZERO
var current_scene = ""
var saved_scene = ""
var playerhp = 10
var enemylistbiome1 = {
	"fumoslime1": {
		"dead": false, 
		"path": "res://obj/combat/fumoslime.tscn",
		"track": "battle"
		},
	"mimic1": {
		"dead": false, 
		"path": "res://obj/combat/mimic.tscn",
		"track": "battle"
		},
	"brother": {
		"dead": false, 
		"path": "res://obj/combat/brother.tscn",
		"track": "bossbattle"
		}
}
