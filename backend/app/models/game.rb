module Geneseo
  module Model
    class Game < ActiveRecord::Base
      serialize :board

      belongs_to :player1, class_name: 'User'
      belongs_to :player2, class_name: 'User'

      def build_board(rows, columns, to_win)
        self.rows = rows #number of rows on connect 4 board
        self.columns = columns #number of columns
        self.to_win = to_win #number in a line to win
        @game_board ||= Array.new(columns)
        self.board = @game_board
        self.save
      end

      def start
        build_board(7, 7, 4)
        self.current_turn = 1
        self.current_player = player_1_id
        self.game_started = true

        save
      end

      def turn(user_id, column)
        self.do_move(user_id, column)
        if self.current_turn >= 49
          self.current_player = -1
          self.game_over = true
          self.save
          return true
        end
        if self.check_win?(user_id)
           self.game_over = true
           self.save
           return true
        end
        self.current_turn = self.current_turn + 1
        if self.current_player == self.player_2_id
          self.current_player = self.player_1_id
        else
          self.current_player = self.player_2_id
        end
        self.save
        return nil
      end

      def do_move(user_id, column)
        colmn = get_column(column)
        unless position(max_row, column)
        colmn << user_id
        end
      end

      # Check if a peice is in a slot
      def position(row, column)
        colmn = get_column(column)
        return colmn[row] unless colmn.nil?
      end

      def current_player?(user_id)
        return user_id == self.current_player
      end

      # Reset the board
      def reset
        self.board = nil
        self.save
      end

      # Check for victory
      def check_win?(playerID)
        vertical_win?(playerID) || horizontal_win?(playerID) || diagonal_win?(playerID) || other_diagonal_win?(playerID)
      end

      def get_column(col)
        @game_board = self.board
        @game_board[col] ||= []
      end

      private

      def max_row
        max_row = self.rows-1 #7 rows, index at 6
      end

      #vertical win check
      def vertical_win?(player)
        win =false
        self.board.each do |column|
          unless column.nil?
            counter = 0
            column.each do |position|
              counter = increment(position, player, counter)
              win ||= win?(counter)
            end
          end
        end
        win
      end

      #horizontal win check
      def horizontal_win?(player)
        win = false
        @rows = self.rows
        (0..@rows).each do |row|
          counter  = 0
          self.board.each_with_index do |column, column_index|
            counter = 0 if column.nil?
            position = position(row, column_index)
            counter = increment(position, player, counter)
            win ||= win?(counter)
          end
        end
        win
      end

      def diagonal_win?(player)
        win = false
        @columns = self.columns
        @to_win = self.to_win
        (0..@columns-@to_win).each do |i|
          counter = 0
          rowlimit = max_row - i
          (0..rowlimit).each do |j|
            position = position(j, i+j)
            counter = increment(position, player, counter)
            win ||= win?(counter)
          end
        end
        win
      end

      def other_diagonal_win?(player)
        win = false
        @columns = self.columns
        @to_win = self.to_win
        (@to_win-1...@columns).each do |i|
          counter = 0
          rowlimit = max_row > i ? i : max_row
          (0..rowlimit).each do |j|
            position = position(j, i-j)
            counter = increment(position, player, counter)
            win ||= win?(counter)
          end
        end
        win
      end

      def increment(position, playerID, counter)
        if position && position == playerID
          return counter.next
        else
          return 0
        end
      end

      def win?(counter)
        counter >= self.to_win
      end
    end
  end
end
