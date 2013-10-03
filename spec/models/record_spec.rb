require 'spec_helper'

describe Speedos::Record do
  context 'scopes' do
    subject { Speedos::Record }
    before do
      @not_success = subject.create(success: false)
      @success     = subject.create(success: true)
    end

    its(:successful) { should     include @success }
    its(:successful) { should_not include @not_success }
  end

  describe '#page' do
    subject { Speedos::Record.create() }
    before do
      subject.log = {'entries' => []}
      subject.save
    end
    it { subject.page('').should be_instance_of Speedos::Entries }
  end

  describe '#pages' do
    subject    { Speedos::Record.create() }
    let(:page) { {'id' => 'page 1'} }
    before     { subject.stub(:log).and_return({'pages' => [page]}) }

    context 'when there isn\'t any page with empty id' do
      it 'returns page 1' do
        subject.should_receive(:page).with('page 1')
        subject.pages
      end
    end

    context 'when the page with empty id' do
      let(:page) { {'id' => ''} }

      it 'returns nothing' do
        subject.should_not_receive(:page).with('page 1')
        subject.pages
      end
    end
  end

  describe '#refresh_information' do
    subject { Speedos::Record.create }

    let(:page)  { double(name: 'name', earliest_start_time: Time.current, latest_end_time: Time.current, total_load_time: 0) }
    let(:pages) { [page] }

    before do
      subject.stub(:pages).and_return(pages)
    end

    it 'populates pages information' do
      subject.refresh_information
      info = subject.information
      info.size.should eq 1
      info.first.page_name.should eq page.name
      info.first.began_at.should eq page.earliest_start_time
      info.first.finished_at.should eq page.latest_end_time
      info.first.total_duration.should eq page.total_load_time
    end

    context 'when there is already information for the record' do
      before { @info = subject.information.create }

      it 'clears all existing records' do
        subject.refresh_information
        subject.information.should_not include @info
      end
    end
  end

end
