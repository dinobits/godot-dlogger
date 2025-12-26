class_name DLog_GodotOutputHanler
extends DLog_AbstractHandler


func handle(record: LogRecord) -> bool:
	if not super.handle(record):
		return false

	match record.level:
		DinoLog.Level.DEBUG:
			printt("DEBUG", record.formatted)
		_:
			printt(record.formatted)

	return true
