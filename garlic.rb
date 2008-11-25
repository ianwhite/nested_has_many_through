garlic do
  repo 'nested_has_many_through', :path => '.'
  
  repo 'rails', :url => 'git://github.com/rails/rails'
  repo 'rspec', :url => 'git://github.com/dchelimsky/rspec'
  repo 'rspec-rails', :url => 'git://github.com/dchelimsky/rspec-rails'
  
  #target 'edge', :branch => 'origin/master'
  target '2.2', :branch => 'origin/2-2-stable'
  target '2.1', :branch => 'origin/2-1-stable'
  target '2.0', :branch => 'origin/2-0-stable'
  
  all_targets do
    prepare do
      plugin 'rspec'
      plugin('rspec-rails') { `script/generate rspec -f` }
      plugin 'nested_has_many_through', :clone => true
    end
  
    run do
      cd "vendor/plugins/nested_has_many_through" do
        sh "rake spec:rcov:verify"
      end
    end
  end
end
