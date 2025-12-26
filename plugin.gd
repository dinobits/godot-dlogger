@tool
extends EditorPlugin

# const Global = preload("./global.gd")
const SCENE = preload("dinolog.tscn")
# const InternalLogger = preload("loggers/logger.gd")
const CLASS_NAME = "Log"

var _log_control: Control
var _icon = preload("res://icon.svg")
var _debugger: EditorDebuggerPlugin


func _enter_tree() -> void:
	if _log_control:
		return

	_log_control = SCENE.instantiate()
	# EditorInterface.get_editor_main_screen().add_child(_log_control)
	add_control_to_bottom_panel(_log_control, "Logger")

	_debugger = DLog_DebuggerPlugin.new(_log_control.get_holder())
	add_debugger_plugin(_debugger)

	# add_custom_type("AbstractLogger", "Resource", Global.AbstractLogger, null)
	# add_custom_type("BasicLogger", "Resource", Global.BasicLogger, null)
	# add_custom_type("NullLogger", "Resource", Global.NullLogger, null)
	# add_
	# add_custom_type("GameLogger", "Resource", InternalLogger, _icon)
	# add_autoload_singleton(CLASS_NAME, "logger.gd")
	# OS.add_logger(Logger.new())

	# var editor: EditorInterface = get_editor_interface()
	#
	# editor.get_editor_main_screen()
	# get_editor_interface().get_editor_settings()


func _exit_tree() -> void:
	if is_instance_valid(_log_control):
		remove_control_from_bottom_panel(_log_control)
		_log_control.queue_free()
	remove_debugger_plugin(_debugger)
	# remove_custom_type("AbstractLogger")
	# remove_custom_type("BasicLogger")
	# remove_custom_type("NullLogger")


func _get_plugin_name() -> String:
	return "DinoLog"


func _has_main_screen() -> bool:
	return false


func _make_visible(visible: bool) -> void:
	_log_control.visible = visible


func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
