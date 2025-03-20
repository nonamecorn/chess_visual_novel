extends Node2D

var ggs = []
var bgs = []
var cbt = preload("res://obj/battle_sys/combatant.tscn")
var queue = []
var current_turn = 0
var current_hero = 0
var link = preload("res://other/lbtn.tscn")
var command = {
	"who": null,
	"what": null,
	"target": null
}
@onready var cp = $cp
@onready var input = $input/VBoxContainer
signal proceed

func _ready():
	innit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		proceed.emit()

func innit():
	refresh()
	for guy in ggs:
		var cbt_inst = cbt.instantiate()
		$allies.add_child(cbt_inst)
		cbt_inst.name = guy
	for guy in bgs:
		var cbt_inst = cbt.instantiate()
		$baddies.add_child(cbt_inst)
		cbt_inst.name = guy
		cbt_inst.flip_h = true
	show_autoload_inp()

func refresh():
	ggs = []
	bgs = []
	queue = []
	for guy in autoload.guys:
		if autoload.guys[guy].gud:
			print("gud")
			if autoload.guys[guy].stats.hp > 0:
				print("alive")
				ggs.append(guy)
			elif !$allies.get_node(guy) == null:
				var gpath = $allies.get_node(guy).get_path()
				if $allies.has_node(gpath):
					$allies.get_node(guy).queue_free()
		else:
			if !autoload.guys[guy].gud:
				print("notgud")
				if autoload.guys[guy].stats.hp > 0:
					print("alive")
					bgs.append(guy)
				else:
					var bpath = $baddies.get_node(guy).get_path()
					if $baddies.has_node(bpath):
						$baddies.get_node(guy).queue_free()

func ai_state():
	for guy in bgs:
		queue.append({
			"who": guy,
			"what": "attack",
			"target": cp.get_random_gud_target()
			})
	dosmtn()

func dosmtn():
	hide_mi()
	if current_turn < queue.size():
		var cmd = queue[current_turn]
		cp.process(queue[current_turn]["who"],
		 queue[current_turn]["what"],
		 queue[current_turn]["target"])
		if autoload.guys[cmd.who].gud:
			$allies.get_node(cmd.who).work_bitch(cmd)
		else:
			$baddies.get_node(cmd.who).work_bitch(cmd)
	else:
		print("1")
		eor()

func ohe():
	current_turn += 1
	dosmtn()

func eor():
	current_turn = 0
	current_hero = 0
	refresh()
	if ggs == []:
		lose()
	elif bgs == []:
		print(ggs,bgs)
		win()
	else:
		show_autoload_inp()

func lose():
	print("you lost")

func win():
	print("you won")

#INPUT SHIT
var autoload_input = {
	"options": [
			{"text": "attack", "next": "attack"},
			{"text": "skill", "next": "skill"},
			{"text": "item", "next": "item"},
		]
}
enum {targetst,autoload_inputst,otherst}
var input_state = targetst
func hide_mi():
	input.visible = false

func show_autoload_inp():
	input.visible = true
	command = {
	"who": null,
	"what": null,
	"target": null
	}
	input_state = autoload_inputst
	if current_hero < ggs.size():
		command.who = ggs[current_hero]
		for child in input.get_children():
			child.queue_free()
		for inputi in autoload_input.options:
			var btn = link.instantiate()
			btn.text = inputi.text
			btn.connect("pressed", Callable(self, "on_btn_prst").bind(inputi.next))
			input.add_child(btn)
	else:
		ai_state()

func show_skill_input():
	for child in input.get_children():
		child.queue_free()
	for skill in ggs[current_hero].skills:
		var btn = link.instantiate()
		btn.text = input.name
		btn.connect("pressed", Callable(self, "on_btn_prst").bind(skill))
		input.add_child(btn)

func show_item_input():
	pass

func target():
	input_state = targetst
	for child in input.get_children():
		child.queue_free()
	for da_target in autoload.guys:
		if autoload.guys[target].stats.hp > 0:
			var btn = link.instantiate()
			btn.text = target
			btn.connect("pressed", Callable(self, "on_btn_prst").bind(target))
			input.add_child(btn)
	

func oie():
	current_hero += 1
	show_autoload_inp()

func on_btn_prst(tg):
	match input_state:
		autoload_inputst:
			match tg:
				"attack":
					command.what = "attack"
					target()
				"skill":
					show_skill_input()
				"item":
					show_item_input()
		targetst:
			command.target = tg
			queue.append(command)
			oie()
		otherst:
			#need match tg for concret skill
			command.what = tg
			target()
