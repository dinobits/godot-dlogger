class_name DLog_EditorHandler
extends DLog_AbstractHandler

signal log_handled(record: LogRecord)


func handle(record: LogRecord) -> bool:
	if not super.handle(record):
		return false

	log_handled.emit(record)
	return true
