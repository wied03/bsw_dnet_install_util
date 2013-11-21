$LOAD_PATH << './lib'
require 'rake'

src="lib"
testdir="spec"

Gem::Specification.new do |s|
  s.name = "bsw_dnet_install_util"
  s.files = FileList["#{src}/**/*",
                     "#{testdir}/**/*.rb"]
  s.test_files = FileList["#{testdir}/**/*.rb"]
  s.version = ENV['version_number']
  s.summary = "Paraffin and dotnetinstaller binaries"
  s.description = "See summary"   
  s.has_rdoc = true
  s.license = 'BSD'  
  s.rdoc_options << '--inline-source' << '--line-numbers'
  s.author = "Brady Wied"
  s.email = "brady@bswtechconsulting.com"          
  s.add_dependency('windows-pr')  
end
