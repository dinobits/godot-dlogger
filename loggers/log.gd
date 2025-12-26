extends Logger

@export var _logger: DLog_AbstractLogger


# Note that this method is not called for messages that use
# `push_error()` and `push_warning()`, even though these are printed to stderr.
func _log_message(message: String, error: bool, is_native: bool = true) -> void:
	# Do something with `message`.
	# `error` is `true` for messages printed to the standard error stream (stderr) with `print_error()`.
	# Note that this method will be called from threads other than the main thread, possibly at the same
	# time, so you will need to have some kind of thread-safety as part of it, like a Mutex.
	pass


func _log_error(
	function: String,
	file: String,
	line: int,
	code: String,
	rationale: String,
	editor_notify: bool,
	error_type: int,
	script_backtraces: Array[ScriptBacktrace]
) -> void:
	var message := (
		"[{time}] INT{event}: {rationale}\n{code}\n{file}:{line} @ {function}()"
		. format(
			{
				"time": Time.get_time_string_from_system(),
				"event": error_type,
				"rationale": rationale,
				"code": code,
				"file": file,
				"line": line,
				"function": function,
			}
		)
	)
	_logger.debug(message)


# func _log_error(function: String, file: String, line: int, code: String, rationale: String, _editor_notify: bool, error_type: int, script_backtraces: Array[ScriptBacktrace]) -> void:
# 	if not _is_valid:
# 		return
# 	var event := Event.WARN if error_type == ERROR_TYPE_WARNING else Event.ERROR
# 	var message := "[{time}] {event}: {rationale}\n{code}\n{file}:{line} @ {function}()".format({
# 		"time": Time.get_time_string_from_system(),
# 		"event": _event_strings[event],
# 		"rationale": rationale,
# 		"code": code,
# 		"file": file,
# 		"line": line,
# 		"function": function,
#  	})
# 	if event == Event.ERROR:
# 		message += '\n' + _get_gdscript_backtrace(script_backtraces)
# 	_add_message_to_file(message, event)
#
# func _log_message(message: String, log_message_error: bool) -> void:
# 	if not _is_valid or message.begins_with("[lang=tlh]"):
# 		return
# 	var event := Event.ERROR if log_message_error else Event.INFO
# 	message = _format_log_message(message.trim_suffix('\n'), event)
# 	_add_message_to_file(message, event)


static func _get_gdscript_backtrace(script_backtraces: Array[ScriptBacktrace]) -> String:
	var gdscript := script_backtraces.find_custom(
		func(backtrace: ScriptBacktrace) -> bool: return backtrace.get_language_name() == "GDScript"
	)
	return "Backtrace N/A" if gdscript == -1 else str(script_backtraces[gdscript])
