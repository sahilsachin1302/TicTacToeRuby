class TicTacToe
    def initialize
      @board = Array.new(3) { Array.new(3, ' ') }
      @current_player = 'X'
    end
  
    def print_board
        puts "   1  2  3"
        @board.each_with_index do |row, index|
          print "#{index + 1} "
          puts row.join('|').gsub(' ', '  ')
          puts "  --------" unless index == 2
        end
    end
  
    def make_move(row, col)
      if @board[row][col] == ' '
        @board[row][col] = @current_player
        return true
      else
        puts "Invalid move. Please try again."
        return false
      end
    end
  
    def switch_player
      @current_player = (@current_player == 'X') ? 'O' : 'X'
    end
  
    def check_win
      # Check rows
      @board.each do |row|
        return true if row.uniq.length == 1 && row[0] != ' '
      end
  
      # Check columns
      @board.transpose.each do |col|
        return true if col.uniq.length == 1 && col[0] != ' '
      end
  
      # Check diagonals
      diagonals = [
        [@board[0][0], @board[1][1], @board[2][2]],
        [@board[0][2], @board[1][1], @board[2][0]]
      ]
      diagonals.each do |diag|
        return true if diag.uniq.length == 1 && diag[0] != ' '
      end
  
      return false
    end
  
    def game_over
      return true if check_win || @board.flatten.none? { |cell| cell == ' ' }
      return false
    end
  
    def play
      puts "Welcome to Tic Tac Toe!"
      print_board
  
      loop do
        puts "Player #{@current_player}'s turn. Enter row and column (1-3) separated by space:"
        row, col = gets.chomp.split.map(&:to_i)
        row -= 1
        col -= 1
        next unless row.between?(0, 2) && col.between?(0, 2)
  
        if make_move(row, col)
          print_board
          if check_win
            puts "Player #{@current_player} wins!"
            break
          elsif game_over
            puts "It's a draw!"
            break
          end
          switch_player
        end
      end
    end
  end
  
  game = TicTacToe.new
  game.play