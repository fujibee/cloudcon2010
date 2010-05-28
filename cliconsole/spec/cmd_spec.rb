require 'hcc'

describe 'cmd' do
  it 'can exec ssh' do
    ssh_cmd('add').chomp.should == 'cl-stool'
  end
end
