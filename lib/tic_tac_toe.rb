
require 'pry'

class TicTacToe

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    WIN_COMBINATIONS = [ 
    [0,1,2], # top_row 
    [3,4,5], # middle_row 
    [6,7,8], # bottom_row 
    [0,3,6], # left_column 
    [1,4,7], # center_column 
    [2,5,8], # right_column 
    [0,4,8], # left_diagonal 
    [6,4,2] # right_diagonal 
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move (index, player)
        @board[index] = player
    end

    def position_taken?(index)
        if (@board[index] == " ")|| (@board[index] == "") || (@board[index] == nil)
          return false
        else
          return true
        end
      end

      def valid_move?(index)
        if index.between?(0, 8) && !position_taken?(index)
          return true
        end
      end

      def turn_count
        @board.count{|token| token == "X" || token == "O"}
      end

      def current_player
        turn_count % 2 == 0 ? "X" : "O"
      end

      def turn
        puts "Please enter 1-9:"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
           move(index, current_player)
        else
           turn
        end
        display_board
      end
      
      def won?
        WIN_COMBINATIONS.find do |combo|
            win_index_1 = combo[0]
            win_index_2 = combo[1]
            win_index_3 = combo[2]
            position_1 = @board[win_index_1] # value of board at win_index_1
            position_2 = @board[win_index_2] # value of board at win_index_2
            position_3 = @board[win_index_3] # value of board at win_index_3
            if position_1 == position_2 && position_2 == position_3 && position_taken?(win_index_1)
              return combo # return the win_combination indexes that won 
          end 
      end
    end
    
    #OR
    # def won?
    # WIN_COMBINATIONS.any? do |combo|
    #   if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
    #    return combo
    #   end 
    #  end 
    # end

    def full?
        @board.all? {|i| i == "X" || i == "O"}
    end

    #or
    # def full?
    #   !@board.any? do |square| 
    #      square == " " 
    #    end
    #  end

    def draw?
        if !won? && full?
          return true
        else 
          return false
        end
      end

      #or
      # def draw?
      # full? && !won?
      # end 
  
      def over?
        if draw? || won? || full?
          return true
        end
      end
  
      #or
      # def over?
      # won? || draw?
      # end

    def winner
        if won?
          return @board[won?[0]]
        end
    end
  
    #or
    #def winner
    #    if combo = won?
    #      @board[combo[0]]
    #    end

    def play
        until over?
           turn
        end 
        if won?
           winner == "X" || winner == "O" 
           puts "Congratulations #{winner}!" 
        elsif draw?
           puts "Cat's Game!" 
        end 
    end

    #or
    #def play
    # turn until over?
    # puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    #end
end
