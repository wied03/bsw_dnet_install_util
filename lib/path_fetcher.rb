module BswTech
  module DnetInstallUtil
    BASE_PATH = File.expand_path(File.dirname(__FILE__))

    PARAFFIN_VERSION = '3.6.2.0'
    PARAFFIN_EXE = File.join BASE_PATH, "Paraffin-#{PARAFFIN_VERSION}", 'Paraffin.exe'

    def dot_net_installer_base_path
      raise 'not implemented yet'
    end
  end
end