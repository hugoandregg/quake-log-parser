load 'Log.rb'

log = Log.new(*ARGV)
log.read_log
log.emit