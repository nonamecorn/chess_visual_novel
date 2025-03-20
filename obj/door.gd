extends StaticBody2D


var dialog = {
	"0": {
		"name": "Переход",
		"txt": "Перейти?",
		"options": [
			{"text": "Да", "next": "-1", "command": ["change_scene",["res://levels/dungeon.tscn"]]},
			{"text": "Нет", "next": "-1"},
		]
	}
}

func start_dil() -> Dictionary:
	return dialog
