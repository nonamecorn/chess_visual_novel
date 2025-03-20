extends TextureProgressBar

var scene : PackedScene = null

func _ready() -> void:
	CommandProcessor.change_scene.connect(change_scene)
	show()
	$AnimationPlayer.play_backwards("fade_in")

func change_scene(scene_path: String) -> void:
	scene = load(scene_path)
	$AnimationPlayer.play("fade_in")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if scene:
		get_tree().change_scene_to_packed(scene)
