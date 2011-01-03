require 'logger'

module Loggit
  $LOG ||= Logger.new('game_log.log')
  $LOG.level = Logger::INFO
end