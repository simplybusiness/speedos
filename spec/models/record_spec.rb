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

end
