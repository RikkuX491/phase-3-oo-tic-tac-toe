require "pry"

class TicTacToe

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

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        index = 0
        while(index < @board.length)
            print " #{@board[index]} "
            if(index != 2 && index != 5 && index != 8)
                print "|"
            else
                puts ""
                if(index != 8)
                    puts "-----------"
                end
            end
        index += 1 
        end
    end

    def input_to_index(index)
        index = index.to_i
        index -= 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(position)
        (!position_taken?(position)) && position >= 0 && position <= 8
    end

    def turn_count
        turns_left_array = @board.filter do |space|
            space == " "
        end
        turns_left = turns_left_array.length
        @board.length - turns_left
    end

    def current_player
        if(turn_count.even?)
            "X"
        else
            "O"
        end
    end

    def turn
        move = gets.chomp
        position = self.input_to_index(move)

        while(!self.valid_move?(position))
            move = gets.chomp
            position = self.input_to_index(move)
        end
        self.move(position, self.current_player)
        self.display_board
    end

    def won?
        WIN_COMBINATIONS.each do |combination|
            if((@board[combination[0]] == 'X' && @board[combination[1]] == 'X' && @board[combination[2]] == 'X') || (@board[combination[0]] == 'O' && @board[combination[1]] == 'O' && @board[combination[2]] == 'O'))
                return combination
            end
        end
        false
    end

    def full?
        @board.filter do |position|
            position == " "
        end.length == 0
    end

    def draw?
        !self.won? && self.full?
    end

    def over?
        self.draw? || !!self.won?
    end

    def winner
        if(!self.won?)
            return nil
        else
            combination = self.won?
            if(@board[combination[0]] == 'X' && @board[combination[1]] == 'X' && @board[combination[2]] == 'X')
                return 'X'
            else
                return 'O'
            end
        end
    end

    def play
        while(!over?)
            turn
        end
        if(winner == 'X' || winner == 'O')
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end
end