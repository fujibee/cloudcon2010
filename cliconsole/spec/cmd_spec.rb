require 'hcc'

describe 'cmd' do
  it 'can exec ssh' do
    test('server').chomp.should == 'cl-stool'
  end
end
