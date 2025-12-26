@tool
extends Control

@onready var log_container: Control = %LogContainer


func get_holder() -> Control:
	return log_container
