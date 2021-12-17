extends Node

onready var player: AudioStreamPlayer = $VoicePlayer


func play_voice(part_id: String) -> void:
	player.play()
