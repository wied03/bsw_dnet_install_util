$: << File.expand_path(File.dirname(__FILE__) +"/../lib")
require 'rspec'
require 'path_fetcher'

describe BswTech::DnetInstallUtil do
  after(:each) do
    FileUtils::rm_rf 'lib/dotNetInstaller-2.2'
    FileUtils::rm_rf 'lib/pstools-2.0'
  end

  it 'should return the full path to paraffin exe in the GEM folder' do
    # arrange

    # act
    result = BswTech::DnetInstallUtil::PARAFFIN_EXE

    # assert
    expect(result).to eq("#{BswTech::DnetInstallUtil::BASE_PATH}/Paraffin-3.6.2.0/Paraffin.exe")
  end

  it 'should return the full path to elevate.exe' do
    # arrange

    # act
    result = BswTech::DnetInstallUtil::ELEVATE_EXE

    # assert
    expect(result).to eq("#{BswTech::DnetInstallUtil::BASE_PATH}/elevate-1.3.0/elevate.exe")
  end

  # http://code.dblock.org/downloads/dotnetinstaller/dotNetInstaller.2.2.zip
  it 'should fetch and expand the DotNetInstaller distro inside the GEM directory and return the path' do
    # arrange

    # act
    result = BswTech::DnetInstallUtil::dot_net_installer_base_path
    fileExists = File.exist?(File.join result, "Bin", "InstallerLinker.exe")

    # assert
    expect(result).to eq("#{BswTech::DnetInstallUtil::BASE_PATH}/dotNetInstaller-2.2")
    expect(fileExists).to be true
    expect(File.exists?("#{BswTech::DnetInstallUtil::BASE_PATH}/dotnetinstaller.zip")).to be false
  end

  it 'should use the already fetched directory' do
    # arrange
    BswTech::DnetInstallUtil::dot_net_installer_base_path
	allow(Net::HTTP).to receive(:start).and_throw("shouldn't be fetching this twice")

    # act
    result = BswTech::DnetInstallUtil::dot_net_installer_base_path
    fileExists = File.exist?(File.join result, "Bin", "InstallerLinker.exe")

    # assert
    expect(result).to eq("#{BswTech::DnetInstallUtil::BASE_PATH}/dotNetInstaller-2.2")
    expect(fileExists).to be true
    expect(File.exists?("#{BswTech::DnetInstallUtil::BASE_PATH}/dotnetinstaller.zip")).to be false
  end

  it 'should fetch PsTools only once' do
    # arrange

    # act
    result = BswTech::DnetInstallUtil::ps_tools_base_path
    file_exists = File.exist?(File.join result, 'PsExec.exe')
    allow(Net::HTTP).to receive(:start).and_throw("shouldn't be fetching this twice")
    result = BswTech::DnetInstallUtil::ps_tools_base_path

    # assert
    expect(result).to eq("#{BswTech::DnetInstallUtil::BASE_PATH}/pstools-2.0")
    expect(file_exists).to be true
    expect(File.exists?("#{BswTech::DnetInstallUtil::BASE_PATH}/PSTools.zip")).to be false
  end
end