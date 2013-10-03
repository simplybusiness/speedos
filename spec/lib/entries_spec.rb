require 'spec_helper'

describe Speedos::Entries do
  describe '#get_earliest_start_time_latest_end_time' do
    subject { Speedos::Entries.new(times) }

    context 'when all tasks start the same time' do
      let(:time) { Time.new(2012,1,1,12) }
      let(:times) do
        [
          {'startedDateTime' => time.to_s, 'time' => 100},
          {'startedDateTime' => time.to_s, 'time' => 50},
        ]
      end

      before { subject.send(:total_load_time) }

      it 'updates earliest_start_time' do
        subject.earliest_start_time.should eq time
      end

      it 'updates the latest_end_time' do
        end_time = Time.at(time.to_f + 100.0/1000)
        subject.latest_end_time.to_f.should eq end_time.to_f
      end
    end

    context 'when tasks are started at the same time' do
      let(:earlier_time) { Time.new(2012,1,1,12,0,0) }
      let(:later_time)   { Time.new(2012,1,1,12,0,1) }
      let(:times) do
        [
          {'startedDateTime' => earlier_time.to_s, 'time' => 100},
          {'startedDateTime' => later_time.to_s,   'time' => 50},
        ]
      end

      it 'updates the total time needed' do
        subject.earliest_start_time.should eq earlier_time
      end

      it 'updates the latest_end_time' do
        end_time = Time.at(later_time.to_f + 50.0/1000)
        subject.latest_end_time.to_f.should eq end_time.to_f
      end
    end
  end

  describe '#total_load_time' do
    subject { Speedos::Entries.new(double) }

    let(:earliest_start_time) { Time.current }
    let(:latest_end_time)     { Time.current }

    before do
      subject.stub(:earliest_start_time).and_return(earliest_start_time)
      subject.stub(:latest_end_time).and_return(latest_end_time)
    end

    context 'when either latest_end_time or earliest_start_time is empty' do
      context 'when either latest_end_time is nil' do
        let(:earliest_start_time) { nil }
        its(:total_load_time) { should eq 0 }
      end

      context 'when either earliest_start_time is nil' do
        let(:earliest_start_time) { nil }
        its(:total_load_time) { should eq 0 }
      end
    end

    context 'when noth latest_end_time or earliest_start_time are not empty' do
      let(:earliest_start_time) { Time.current }
      let(:latest_end_time)     { Time.current + 1.second }

      its(:total_load_time) { should eq (latest_end_time - earliest_start_time) * 1000 }
    end
  end

  describe '#name' do
    subject { Speedos::Entries.new([{'pageref' => 'page 1'}, {'pageref' => 'page 1'},]) }

    its(:name) { should eq 'page 1' }
  end
end
