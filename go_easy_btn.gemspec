Gem::Specification.new do |s|
  s.name = %q{go_easy_btn}
  s.version = "0.0.5"
  s.has_rdoc = false
  s.required_ruby_version = ">= 1.8.7"
  s.platform = "ruby"
  s.executables << 'go_easy_btn'
  s.require_paths = ['lib']
  s.required_rubygems_version = ">= 0"
  s.add_dependency 'serialport'
  s.author = "Josh Nussbaum, Diego Salazar"
  s.email = ["joshnuss@gmail.com", "diego@pixelheadstudio.com"]
  s.summary = %q{Make things Easy!}
  s.homepage = %q{https://github.com/joshnuss/easy-button}
  s.description = %q{Hook up easy button via USB serial port and trigger shell commands}
  s.files = ["lib/go_easy_btn.rb", "lib/alerter.rb", "bin/go_easy_btn"]
end
