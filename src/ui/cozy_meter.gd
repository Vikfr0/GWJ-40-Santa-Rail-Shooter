extends Control

onready var progress_bar = $VBoxContainer/ProgressBar


func _ready() -> void:
	get_tree().get_nodes_in_group("player")[0].connect("santa_coziness_updated", self, "_update_cozy_meter")
	

func _update_cozy_meter(coziness: int) -> void:
	progress_bar.value = coziness
