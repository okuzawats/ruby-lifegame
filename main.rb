require_relative './lib/board'

CLEAR = 'clear'
ONE_SECOND = 1

board = Board.new

while true
  system CLEAR
  board.display
  board.update
  sleep ONE_SECOND
end
