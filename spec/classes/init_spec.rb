require 'spec_helper'
describe 'newrelic' do
  context 'with type os' do
    let(:params) { {:type => {'os' => {'key' => '8fb13cf1873e95f60045afe67fc3a6aba9e563da'}}}}

    it { should compile }
  end

  context 'with type php' do
     let(:params) { {:type => {'php' => {'key' => '8fb13cf1873e95f60045afe67fc3a6aba9e563da'}}}}

    it { should compile }
  end

  context 'with type java' do
    let(:params) { {:type => {'java' => {'key' => '8fb13cf1873e95f60045afe67fc3a6aba9e563da'}}}}

    it { should compile }
  end

  context 'with type nodejs' do
    let(:params) { {:type => {'nodejs' => {'key' => '8fb13cf1873e95f60045afe67fc3a6aba9e563da'}}}}

    it { should compile }
  end
end
