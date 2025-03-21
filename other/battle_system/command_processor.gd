extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func process(who, cares, target):
	match cares:
		"attack":
			take_v(who, target)

func take_v(attr, dfdr):
	var dmg = rng.randi_range(autoload.guys[attr].stats.att[0], autoload.guys[attr].stats.att[1])
	if autoload.guys.has(dfdr):
		autoload.guys[dfdr].stats.hp -= dmg
		print("%s takes %s damage" % [dfdr, dmg])

func get_random_gud_target():
	var a = autoload.guys.keys()
	a = a[randi() % a.size()]
	if autoload.guys[a].gud:
		return a
	else:get_random_gud_target()
