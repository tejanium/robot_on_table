#     N
#
# W   o   E
#
#     S

module RobotOnTable
  class Robot
    attr_reader :x, :y, :facing

    MAX_X = 5
    MAX_Y = 5

    FACING = %w(north east south west) # DO NOT CHANGE ORDER
    SYMBOL = %w(↑ → ↓ ←)

    VISUALIZE = Hash[FACING.zip(SYMBOL)]

    def initialize(x, y, facing)
      @x, @y  = x.to_i, y.to_i
      @facing = facing

      validate_position!
    end

    def report
      [@x, @y, @facing].join(', ')
    end

    def print_report
      puts report.upcase
    end

    def move
      @y = @y.succ if able_to_move_north?
      @x = @x.succ if able_to_move_east?
      @y = @y.pred if able_to_move_south?
      @x = @x.pred if able_to_move_west?
    end

    def turn_right
      @facing = FACING[facing_index - FACING.size + 1]
    end

    def turn_left
      @facing = FACING[facing_index - 1]
    end

    def visualize
      table = Array.new(MAX_X) { Array.new(MAX_Y) { ' ' } }

      table[@y][@x] = VISUALIZE[@facing]

      table.reverse.each do |row|
        puts row.inspect
      end

      nil
    end

    private
      def facing_index
        FACING.index @facing
      end

      def validate_position!
        raise if !valid_position? || !valid_facing?
      end

      def valid_position?
        valid_x_position? && valid_y_position?
      end

      def valid_facing?
        FACING.include? @facing
      end

      def valid_x_position?
        (0...MAX_X).cover? @x
      end

      def valid_y_position?
        (0...MAX_Y).cover? @y
      end

      def able_to_move_north?
        @facing == 'north' && @y < MAX_Y.pred
      end

      def able_to_move_east?
        @facing == 'east' && @x < MAX_X.pred
      end

      def able_to_move_south?
        @facing == 'south' && @y > 0
      end

      def able_to_move_west?
        @facing == 'west' && @x > 0
      end
  end
end
