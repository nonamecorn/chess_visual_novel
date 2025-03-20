extends StaticBody2D


var dialog = {
	"0": {
		"name": "Плейсхолдер",
		"texture": "character_placeholder.png",
		"txt": "Привет?",
		"options": [
			{"text": "Да", "next": "1"},
			{"text": "Нет", "next": "-1"},
			{"text": "Хаха", "next": "0"},
			{"text": "Хахаа", "next": "0"}
		]
	},
	"1": {
		"name": "Плейсхолдер",
		"texture": "character_placeholder_angy.png",
		"txt": "Е?",
		"options": [
			{"text": "Да", "next": "-1"},
			{"text": "Нет", "next": "-1"}
		]
	}
}

func start_dil() -> Dictionary:
	return dialog
