module A
    class Gem
        class << self
            def index(config)
                dir = config[:dir]
                target = config[:target]

              #  puts Dir.pwd

               # puts target

                Dir.mkdir dir rescue nil

                Dir.chdir dir
                Dir.mkdir 'lib' rescue nil
                Dir.mkdir 'bin' rescue nil


                rakefile = <<-eot
def latest_gem
    Dir["*.gem"].sort.last
end 

task :default do
    puts `gem build #{dir}.gemspec`
    if $?.success?
        puts "\\nyou can install it with:"
        puts "gem install --local \#{latest_gem}\\n"
        puts "run your app with:\\n#{dir}\\n"
            
    end    
end
eot
                gemspec = <<-eot
Gem::Specification.new do |s|
    s.name = "#{dir}"
    s.version = "0.0.1"
    s.summary = "summary"
    s.authors = ['authors']

    s.license = 'MIT'
    s.email = 'degcat@126.com'
    s.homepage = 'https://rubygems.org/gems/a'

    s.files =  Dir["lib/*.rb"]
    s.executables = ["#{dir}"]
end
                eot
                IO.write "#{dir}.gemspec",gemspec
                IO.write "rakefile.rb",rakefile
                IO.write "lib/#{dir}.rb",''

                binfile=<<-eot
#!/usr/bin/env ruby                
puts "hello world!"
eot
                IO.write "bin/#{dir}",binfile
 


#puts gemspec

            end
        end
    end
end
