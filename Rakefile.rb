require 'prawn'
require 'github/markup'

namespace :generate do
  desc "Generate a pdf from the Readme doc"
  task :pdf do
    puts 'generating a pdf from the markdown readme file'
    `gimli -merge -stylesheet styles.css -outputfilename Resume -file README.md`
  end

  desc "Generate the html from the markdown for the index"
  task :index do
    html_file = <<eos 
<html>
<head>
  <title>David Morrow Resume</title>
   <link href=\"styles.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />
</head>
<body>
  <!--the content-->
</body>
</html>
eos

    puts "rendering the index.html file from the readme markdown file"
    content = GitHub::Markup.render('README.md')
    file = File.open "index.html", "w"
    file.write html_file.gsub('<!--the content-->', content)
    # `open "index.html"`
  end

  desc "publish the index page and the pdf"
  task :all do
    Rake::Task["generate:pdf"].execute
    Rake::Task["generate:index"].execute
  end
  
  desc "push to gh-pages branch"
  task :publish do
    `git add -A`
    `git commit -m "publishing pdf and index.html"`
    `git push origin master`
    `git checkout gh-pages`
    `git merge origin/master`
    `git checkout master`
  end
end
