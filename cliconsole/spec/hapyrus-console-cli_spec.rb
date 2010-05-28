require 'hapyrus-console-cli'

describe 'hapyrus colsone cli' do
  it 'can exec ssh' do
    ssh_cmd('hostname').chomp.should == 'cl-stool'
  end
end
