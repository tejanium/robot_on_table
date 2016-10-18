module RobotOnTable
  class CommandParser
    VALID_COMMANDS = {
      'place'  => 'new',
      'report' => 'print_report',
      'move'   => 'move',
      'right'  => 'turn_right',
      'left'   => 'turn_left',
      'print'  => 'visualize'
    }

    def initialize(command_string)
      @command, @params = command_string.downcase.split(/\s+/)

      validate_command!
    end

    def initialize_command?
      VALID_COMMANDS.keys.first == @command && params
    end

    def robot_command
      VALID_COMMANDS[command]
    end

    def params
      @params.chomp.split(',') rescue nil
    end

    private
      def command
        @command.chomp
      end

      def validate_command!
        return if valid_command?

        raise "Invalid command! Available commands are: #{ VALID_COMMANDS.keys.map(&:upcase) }"
      end

      def valid_command?
        VALID_COMMANDS.keys.include? command
      end
  end
end
