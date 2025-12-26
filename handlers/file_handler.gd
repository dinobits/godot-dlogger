class_name DLog_FileHandler
extends DLog_AbstractHandler

@export var _file_path: String = "user://logs/{time}.log"
@export var _buffer_size: int

var _log_file: FileAccess
var _handle: Callable
var _till_flush: int
var _mutex := Mutex.new()


func _init() -> void:
	_handle = _first_time_handle


func handle(record: LogRecord) -> bool:
	return _handle.call(record)


func reset() -> void:
	if _log_file.is_open():
		_log_file.flush()
		_till_flush = _buffer_size


func _write_handle(record: LogRecord) -> bool:
	if super.handle(record):
		_write(record)
		return true
	return false


func _write(record: LogRecord) -> void:
	_mutex.lock()
	_log_file.store_line(record.formatted)
	_till_flush -= 1
	if _till_flush < 0:
		_till_flush = _buffer_size
		_log_file.flush()
	_mutex.unlock()


func _first_time_handle(record: LogRecord) -> bool:
	var file_path = _file_path
	if _file_path:
		file_path = _file_path.format({"time": Time.get_datetime_string_from_system()})
	else:
		var file_name := Time.get_datetime_string_from_system() + ".log"
		file_path = "user://logs/" + file_name

	_log_file = _create_log_file(file_path)
	if _log_file and _log_file.is_open():
		_till_flush = _buffer_size
		_handle = _write_handle
		_write_handle(record)
		return true
	else:
		push_error(
			"Unable to open log file: %s. Error: %s" % [file_path, str(FileAccess.get_open_error())]
		)
		return false


func _create_log_file(file_path: String) -> FileAccess:
	var file := FileAccess.open(file_path, FileAccess.WRITE)
	return file
