require 'spec_helper'

describe RobotOnTable::Robot do
  context '#initialize' do
    it 'placed in correct coordinate' do
      expect { described_class.new(0, 0, 'north') }.not_to raise_error
    end

    it 'placed in incorrect coordinate' do
      expect { described_class.new(-1, 0, 'north') }.to raise_error StandardError
    end

    it 'placed in outside the accepted coordinate' do
      expect { described_class.new(5, 0, 'north') }.to raise_error StandardError
    end

    it 'placed in correct coordinate but wrong facing' do
      expect { described_class.new(0, 0, 'foobar') }.to raise_error StandardError
    end
  end

  context '#report' do
    let(:robot) { described_class.new(0, 0, 'north') }

    it 'print current location' do
      expect(robot.report).to eql "0, 0, north"
    end
  end

  context '#move' do
    context 'facing "north"' do
      let(:robot) { described_class.new(0, 0, 'north') }

      it 'change the y + 1' do
        expect { robot.move }.to change{ robot.y }.from(0).to 1
      end

      it 'not to change the x' do
        expect { robot.move }.not_to change{ robot.x }.from 0
      end

      it 'does not allow robot to move more than 5 times' do
        expect {
          10.times { robot.move }
        }.to change{ robot.y }.from(0).to 4
      end
    end

    context 'facing "south"' do
      let(:robot) { described_class.new(0, 4, 'south') }

      it 'change the y - 1' do
        expect { robot.move }.to change{ robot.y }.from(4).to 3
      end

      it 'not to change the x' do
        expect { robot.move }.not_to change{ robot.x }.from 0
      end

      it 'does not allow robot to move more than 5 times' do
        expect {
          10.times { robot.move }
        }.to change{ robot.y }.from(4).to 0
      end
    end

    context 'facing "east"' do
      let(:robot) { described_class.new(0, 0, 'east') }

      it 'change the x + 1' do
        expect { robot.move }.to change{ robot.x }.from(0).to 1
      end

      it 'not to change the y' do
        expect { robot.move }.not_to change{ robot.y }.from 0
      end

      it 'does not allow robot to move more than 5 times' do
        expect {
          10.times { robot.move }
        }.to change{ robot.x }.from(0).to 4
      end
    end

    context 'facing "west"' do
      let(:robot) { described_class.new(4, 0, 'west') }

      it 'change the x - 1' do
        expect { robot.move }.to change{ robot.x }.from(4).to 3
      end

      it 'not to change the y' do
        expect { robot.move }.not_to change{ robot.y }.from 0
      end

      it 'does not allow robot to move more than 5 times' do
        expect {
          10.times { robot.move }
        }.to change{ robot.x }.from(4).to 0
      end
    end
  end

  context '#turn_right' do
    it 'change to "east", from "north"' do
      robot = described_class.new(0, 0, 'north')

      expect{ robot.turn_right }.to change { robot.facing }.from('north').to 'east'
    end

    it 'change to "south", from "east"' do
      robot = described_class.new(0, 0, 'east')

      expect{ robot.turn_right }.to change { robot.facing }.from('east').to 'south'
    end

    it 'change to "west", from "south"' do
      robot = described_class.new(0, 0, 'south')

      expect{ robot.turn_right }.to change { robot.facing }.from('south').to 'west'
    end

    it 'change to "north", from "west"' do
      robot = described_class.new(0, 0, 'west')

      expect{ robot.turn_right }.to change { robot.facing }.from('west').to 'north'
    end
  end

  context '#turn_left' do
    it 'change to "west", from "north"' do
      robot = described_class.new(0, 0, 'north')

      expect{ robot.turn_left }.to change { robot.facing }.from('north').to 'west'
    end

    it 'change to "south", from "west"' do
      robot = described_class.new(0, 0, 'west')

      expect{ robot.turn_left }.to change { robot.facing }.from('west').to 'south'
    end

    it 'change to "east", from "south"' do
      robot = described_class.new(0, 0, 'south')

      expect{ robot.turn_left }.to change { robot.facing }.from('south').to 'east'
    end

    it 'change to "north", from "east"' do
      robot = described_class.new(0, 0, 'east')

      expect{ robot.turn_left }.to change { robot.facing }.from('east').to 'north'
    end
  end

  context 'sample data' do
    it 'can run real data' do
      # PLACE 1,2,EAST
      # MOVE
      # MOVE
      # LEFT
      # MOVE
      # REPORT
      # Output: 3,3,NORTH

      robot = described_class.new 1, 2, 'east'

      robot.move
      robot.move
      robot.turn_left
      robot.move

      expect(robot.report).to eql '3, 3, north'
    end
  end
end
