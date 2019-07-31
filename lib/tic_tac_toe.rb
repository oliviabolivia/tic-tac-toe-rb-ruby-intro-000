WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

 display_board(board)

def input_to_index(user_input)
   user_input.to_i - 1
end

def move(board, index, player)
   board[index] = player
end

def position_taken?(board, index)
  board[index] == 'X' || board[index] == 'O'
end

def valid_move?(board, index)
  if index.between?(0,8) == true && position_taken?(board, index) == false
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9: "
  input = gets.strip.to_i
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.count do |token|
    token == "X" || token == "O"
  end
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    position_1 = board[win[0]]
    position_2 = board[win[1]]
    position_3 = board[win[2]]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win

    end
  end
return false
end

def full?(board)
  board.all? { |token| token == 'X' || token == 'O' }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board)
end


def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)
  turn_count = 0
  while turn_count < 9
    turn(board)
    turn_count += 1
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
