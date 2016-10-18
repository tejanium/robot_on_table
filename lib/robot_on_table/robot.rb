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
      case @facing
        when 'north'
          @y += 1 if able_to_move_north?
        when 'east'
          @x += 1 if able_to_move_east?
        when 'south'
          @y -= 1 if able_to_move_south?
        when 'west'
          @x -= 1 if able_to_move_west?
      end
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
        raise StandardError if !valid_position? || !valid_facing?
      end

      def valid_position?
        valid_x_position? && valid_y_position?
      end

      def valid_facing?
        FACING.include? @facing
      end

      def valid_x_position?
        (0...MAX_X).include? @x
      end

      def valid_y_position?
        (0...MAX_Y).include? @y
      end

      def able_to_move_north?
        @y < MAX_Y - 1
      end

      def able_to_move_east?
        @x < MAX_X - 1
      end

      def able_to_move_south?
        @y > 0
      end

      def able_to_move_west?
        @x > 0
      end
  end
end
