class_name DLog_DebugHandler
extends DLog_AbstractHandler

const PREFIX = DLog_DebuggerPlugin.PREFIX + ":"


func handle(record: LogRecord) -> bool:
	if not super.handle(record):
		return false

	EngineDebugger.send_message(PREFIX + record.formatted, [])

	return true
