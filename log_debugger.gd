class_name DLog_DebuggerPlugin
extends EditorDebuggerPlugin

signal message_captured(message: String, data: Array, session_id: int)
const PREFIX = "dlog"

var _holder: Node


func _init(holder: Node) -> void:
	_holder = holder


func _has_capture(capture: String) -> bool:
	return capture == PREFIX


func _capture(message: String, data: Array, session_id: int) -> bool:
	var label: Label = Label.new()
	label.text = message
	_holder.add_child(label)

	message_captured.emit(message, data, session_id)

	return true

# func _setup_session(session_id):
# 	# Add a new tab in the debugger session UI containing a label.
# 	var label = Label.new()
# 	label.name = "Example plugin"  # Will be used as the tab title.
# 	label.text = "Example plugin"
# 	var session = get_session(session_id)
# 	# Listens to the session started and stopped signals.
# 	session.started.connect(func(): print("Session started"))
# 	session.stopped.connect(func(): print("Session stopped"))
# 	session.add_session_tab(label)
