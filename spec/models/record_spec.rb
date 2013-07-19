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

  context '#page' do
    subject { Speedos::Record.create() }
    before do
      subject.log = {'entries' => []}
      subject.save
    end
    it { subject.page('').should be_instance_of Speedos::Entries }
  end

end
