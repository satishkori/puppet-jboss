require 'spec_helper'

describe Puppet_X::Coi::Jboss::Internal::ExecutionStateWrapper do
  context 'execute method' do
    let(:mocked_shell_executor) { Testing::Mock::MockedShellExecutor.new }

    let(:instance) { described_class.new(mocked_shell_executor) }
    subject { instance.execute(cmd, jbosscmd, environment) }

    context 'destroy method' do
      before :each do
        mocked_shell_executor.register_command(
          '/profille=full-ha/subsystem=securitydomain:remove()',
          'asdads',
          true,
          true)
      end
      let(:cmd) { '/profille=full-ha/subsystem=securitydomain:remove()' }
      let(:jbosscmd) { 'asd' }
      let(:environment) { { :password => 'password' } }
      it { expect(subject.success).to eq(true) }
    end

    context 'read method' do
      before :each do
        mocked_shell_executor.register_command(
          '/profille=full-ha/subsystem=securitydomain:read-resource(recursive=true)',
          'result => succes, asdadass',
          true,
          true)
      end
      let(:cmd) { '/profille=full-ha/subsystem=securitydomain:read-resource(recursive=true)' }
      let(:jbosscmd) { 'asd' }
      let(:environment) { { :password => 'password' } }
      it { expect(subject.success).to eq(true) }
    end
  end
end
