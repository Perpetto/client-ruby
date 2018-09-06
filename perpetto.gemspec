Gem::Specification.new do |s|
  s.name = %q{perpetto}
  s.authors     = ["Yavor Stoychev"]
  s.email       = 'yavor@perpetto.com'
  s.version = '0.0.1'
  s.date = %q{2018-09-06}
  s.summary = %q{API client for Perpetto}
  s.files = [
    'lib/perpetto/api.rb'
  ]
  s.require_paths = ['lib']
  s.licenses    = ['MIT']
  s.homepage    = 'https://github.com/Perpetto/client-ruby'
  s.metadata    = { 'source_code_uri' => 'https://github.com/Perpetto/client-ruby' }
  s.add_runtime_dependency 'httparty'
  s.add_runtime_dependency 'bundler'
end
