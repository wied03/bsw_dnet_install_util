require 'net/http'
require 'zip/zip'

module BswTech
  module DnetInstallUtil
    BASE_PATH = File.expand_path(File.dirname(__FILE__))

    PARAFFIN_VERSION = '3.6.2.0'
    PARAFFIN_EXE = File.join BASE_PATH, "Paraffin-#{PARAFFIN_VERSION}", 'Paraffin.exe'
    ELEVATE_VERSION = '1.3.0'
    ELEVATE_EXE = File.join BASE_PATH, "elevate-#{ELEVATE_VERSION}", 'elevate.exe'
    DOTNETINSTALLER_VERSION = '2.2'
    DOTNET_INSTALLER_PATH = File.join BASE_PATH, "dotNetInstaller-#{DOTNETINSTALLER_VERSION}"
    PSTOOLS_VERSION = '2.0'
    PSTOOLS_PATH = File.join BASE_PATH, "pstools-#{PSTOOLS_VERSION}"

    def self.ps_tools_base_path
      if not Dir.exists? PSTOOLS_PATH
        downloaded_zip = get_zip_file 'http://download.sysinternals.com/files/PSTools.zip',
                                      'pstools.zip'
        extract_zip downloaded_zip, PSTOOLS_PATH
        File.delete downloaded_zip
      else
        puts "Using existing distro at #{PSTOOLS_PATH}"
      end
      PSTOOLS_PATH
    end

    def self.dot_net_installer_base_path
      if not Dir.exists? DOTNET_INSTALLER_PATH
        downloaded_zip = get_zip_file 'http://code.dblock.org/downloads/dotnetinstaller/dotNetInstaller.2.2.zip',
                                      'dotnetinstaller.zip'
        extract_zip downloaded_zip, BASE_PATH
        File.delete downloaded_zip
        File.rename(File.join(BASE_PATH, 'dotNetInstaller 2.2'), DOTNET_INSTALLER_PATH)
      else
        puts "Using existing distro at #{DOTNET_INSTALLER_PATH}"
      end
      DOTNET_INSTALLER_PATH
    end

    private

    def self.extract_zip(downloaded_zip,base_path)
      puts "Extracting ZIP to #{base_path}"
      Zip::ZipFile.open downloaded_zip do |zipFile|
        zipFile.entries.each do |f|
          dir = File.join(base_path, File.dirname(f.name))
          FileUtils.mkpath dir
          zipFile.extract(f, File.join(base_path, f.name))
        end
      end
    end

    def self.get_zip_file(url, local_file)
      uri = URI url
      zip = File.join BASE_PATH, local_file
      return zip if File.exist? zip
      Net::HTTP.start uri.host, uri.port do |http|
        puts "Downloading #{url} ..."
        resp = http.get uri.request_uri
        puts "Saving ZIP file to #{zip}"
        open zip, "wb" do |file|
          file.write resp.body
        end
      end
      zip
    end
  end
end