Gem::Specification.new do |s|
  s.name         = "pragmatic_ruby_lesson"
  s.version      = "1.0.0"
  s.author       = "Ellery Temple Jr."
  s.email        = "elreyatee@gmail.com"
  s.homepage     = "http://online.promaticstudio.com"
  s.summary      = "Pragmatic Online Ruby Lessons"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.licenses     = ['MIT']

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'studio_game' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end
