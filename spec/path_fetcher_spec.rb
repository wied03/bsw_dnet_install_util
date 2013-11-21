$: << File.expand_path(File.dirname(__FILE__) +"/../lib")
require 'rspec'
require 'path_fetcher'

describe BswTech::DnetInstallUtil do
  after(:each) do
    FileUtils::rm_rf 'lib/dotNetInstaller-2.2'
  end

  it 'should return the full path to paraffin exe in the GEM folder' do
    # arrange

    # act
    result = BswTech::DnetInstallUtil::PARAFFIN_EXE

    #To change this template use File | Settings | File Templates.
    expect(result).to eq("#{BswTech::DnetInstallUtil::BASE_PATH}/Paraffin-3.6.2.0/Paraffin.exe")
  end

  # http://code.dblock.org/downloads/dotnetinstaller/dotNetInstaller.2.2.zip
  it "should fetch and expand the DotNetInstaller distro inside the GEM directory and return the path" do
    # arrange

    # act
    result = BswTech::DnetInstallUtil::dot_net_installer_base_path
    fileExists = File.exist?(File.join result,"Bin","InstallerLinker.exe")

    # assert
    expect(result).to eq("#{BswTech::DnetInstallUtil::BASE_PATH}/dotNetInstaller-2.2")
    expect(fileExists).to be_true
    expect(File.exists?("#{BswTech::DnetInstallUtil::BASE_PATH}/dotnetinstaller.zip")).to be_false
  end

  it "should use the already fetched directory" do
    # arrange
    BswTech::DnetInstallUtil::dot_net_installer_base_path
    Net::HTTP.stub(:start).and_throw("shouldn't be fetching this twice")

    # act
    result = BswTech::DnetInstallUtil::dot_net_installer_base_path
    fileExists = File.exist?(File.join result,"Bin","InstallerLinker.exe")

    # assert
    expect(result).to eq("#{BswTech::DnetInstallUtil::BASE_PATH}/dotNetInstaller-2.2")
    expect(fileExists).to be_true
    expect(File.exists?("#{BswTech::DnetInstallUtil::BASE_PATH}/dotnetinstaller.zip")).to be_false
  end
end