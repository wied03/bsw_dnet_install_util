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

    def self.dot_net_installer_base_path
      if not Dir.exists? DOTNET_INSTALLER_PATH
        downloaded_zip = get_zip_file
        puts "Extracting ZIP"
        extract_zip downloaded_zip
        File.delete downloaded_zip
        File.rename(File.join(BASE_PATH,'dotNetInstaller 2.2'),DOTNET_INSTALLER_PATH)
      else
        puts "Using existing distro at #{DOTNET_INSTALLER_PATH}"
      end
      DOTNET_INSTALLER_PATH
    end

    private

    def self.extract_zip(downloaded_zip)
      Zip::ZipFile.open downloaded_zip do |zipFile|
        zipFile.entries.each do |f|
          dir = File.join(BASE_PATH, File.dirname(f.name))
          FileUtils.mkpath dir
          zipFile.extract(f, File.join(BASE_PATH, f.name))
        end
      end
    end

    def self.get_zip_file
      uri = URI "http://code.dblock.org/downloads/dotnetinstaller/dotNetInstaller.2.2.zip"
      zip = File.join BASE_PATH, 'dotnetinstaller.zip'
      return zip if File.exist? zip
      Net::HTTP.start uri.host, uri.port do |http|
        puts "Downloading DotNet Installer..."
        resp = http.get uri.request_uri
        puts "Saving ZIP file to #{zip}"
        open zip, "wb" do |file|
          file.write resp.body
        end
      end
      zip
    end

    DOTNET_INSTALLER_PATH = File.join BASE_PATH, "dotNetInstaller-#{DOTNETINSTALLER_VERSION}"
  end
end