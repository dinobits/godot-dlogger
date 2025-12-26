@abstract class_name DLog_AbstractFormatter
extends Resource

const DinoLog = preload("../global.gd")
const LogRecord = DinoLog.LogRecord

@abstract func format(record: LogRecord) -> String
