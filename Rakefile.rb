require 'prawn'

namespace :generate do
  desc "Generate a pdf from the Readme doc"
  task :pdf do
    `gimli -merge -stylesheet styles.css -outputfilename Resume -file README.md`
  end
end
