@abstract class_name DLog_AbstractProcessor
extends Resource

const Global = preload("../global.gd")
const LogRecord = Global.LogRecord

@abstract func process(record: LogRecord) -> LogRecord
