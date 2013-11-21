$: << File.expand_path(File.dirname(__FILE__) +"/../lib")
require 'rspec'
require 'path_fetcher'

describe BswTech::DnetInstallUtil do

  it 'should return the full path to paraffin exe in the GEM folder' do

    #To change this template use File | Settings | File Templates.
    true.should == false
  end

  # http://code.dblock.org/downloads/dotnetinstaller/dotNetInstaller.2.2.zip
  it "should fetch and expand the DotNetInstaller distro inside the GEM directory and return the path" do
    true.should == false
  end

  it "should use the already fetched directory" do
    true.should == false
  end
end