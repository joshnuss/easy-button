Gem::Specification.new do |s|
  s.name = %q{go_easy_btn}
  s.version = "0.0.2"
  s.has_rdoc = false
  s.required_ruby_version = ">= 1.8.7"
  s.platform = "ruby"
  s.require_paths = ['lib', 'bin']
  s.required_rubygems_version = ">= 0"
  s.add_dependency 'serialport'
  s.author = "Josh Nussbaum, Diego Salazar"
  s.email = ["joshnuss@gmail.com", "diego@pixelheadstudio.com"]
  s.summary = %q{Make things Easy!}
  s.homepage = %q{https://github.com/joshnuss/easy-button}
  s.description = %q{Hook up easy button via USB serial port and trigger shell commands}
  s.files = ["lib/big_ass_button.rb", "lib/alerter.rb", "lib/big_ass_button.rb", "bin/go_easy_btn"]
end