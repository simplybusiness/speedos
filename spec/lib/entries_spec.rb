require 'spec_helper'

describe Entries do
  context '#total_load_time' do
    subject { Entries }

    context 'when all tasks start the same time' do
      it 'returns the greatest load time' do
        entries = subject.new([
          {'startedDateTime' => DateTime.new(2012,1,1,12).to_s, 'time' => 100},
          {'startedDateTime' => DateTime.new(2012,1,1,12).to_s, 'time' => 50},
        ])
        entries.total_load_time.should eq 100
      end
    end

    context 'when tasks are started at the same time' do
      it 'returns the total time needed' do
        entries = subject.new([
          {'startedDateTime' => DateTime.new(2012,1,1,12,0,0).to_s, 'time' => 100},
          {'startedDateTime' => DateTime.new(2012,1,1,12,0,1).to_s, 'time' => 50},
        ])
        entries.total_load_time.should eq 1050
      end
    end
  end

  context '#all_names' do
    subject { Entries.new([{'pageref' => 'page 1'}, {'pageref' => 'page 2'},]) }

    its(:all_names) { should =~ ['page 1', 'page 2'] }
  end
end
