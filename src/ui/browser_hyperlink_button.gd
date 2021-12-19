extends LinkButton

export var url = "https://discord.gg/RYCeQ7GDRk"


func _on_LinkButton_pressed() -> void:
	OS.shell_open(url)
