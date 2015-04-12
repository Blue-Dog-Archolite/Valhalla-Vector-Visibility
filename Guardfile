# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features)

## Uncomment to clear the screen before every task
# clearing :on

## Guard internally checks for changes in the Guardfile and exits.
## If you want Guard to automatically start up again, run guard in a
## shell loop, e.g.:
##
##  $ while bundle exec guard; do echo "Restarting Guard..."; done
##
## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

# Note: The cmd option is now required due to the increasing number of ways
#       rspec may be run, below are examples of the most common uses.
#  * bundler: 'bundle exec rspec'
#  * bundler binstubs: 'bin/rspec'
#  * spring: 'bin/rspec' (This will use spring if running and you have
#                          installed the spring binstubs per the docs)
#  * zeus: 'zeus rspec' (requires the server to be started separately)
#  * 'just' rspec: 'rspec'
group :red_green_refactor, halt_on_fail: true do
  guard :rspec, cmd: 'rspec --format progress', all_on_start: false, all_after_pass: false do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')                        { 'spec' }

    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$})  do |m|
      ["spec/routing/#{m[1]}_routing_spec.rb",
       "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb",
       "spec/acceptance/#{m[1]}_spec.rb"]
    end

    watch(%r{^app/services/(.+)\.rb$})                  { |m| "spec/services/#{m[1]}_spec.rb" }
    watch(%r{^app/controllers/api/(.+)\.rb$})           { |m| "spec/integration/#{m[1]}_spec.rb" }
    watch(%r{^app/utility/(.+)\.rb$})                   { |m| "spec/utility/#{m[1]}_spec.rb" }
    watch(%r{^app/presenters/(.+)\.rb$})                { |m| "spec/presenters/#{m[1]}_spec.rb" }
    watch(%r{^app/utility/interfaces/(.+)\.rb$})        { |m| "spec/utility/interfaces/#{m[1]}_spec.rb" }
    watch(%r{^spec/support/(.+)\.rb$})                  { 'spec' }
    watch('config/routes.rb')                           { 'spec/routing' }
    watch('app/controllers/application_controller.rb')  { 'spec' }
  end


  if ENV['STYLE_ENFORCEMENT']
    guard :rubocop, all_on_start: false, keep_failed: false do
      ignore(%r{factory.rb})
      watch(%r{.+\.rb$})
      watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
    end
  end
end

=begin
guard :jasmine, server: :webrick, server_mount: '/specs', all_on_start: false, port: 4747 do
  watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$})         { "spec/javascripts" }
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)$})  { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
end
=end

if ENV['GUARD_BUNDLE']
  guard :bundler do
    watch('Gemfile')
  end
end

if ENV['AUTO_MIGRATE']
  guard 'migrate' do
    watch(%r{^db/migrate/(\d+).+\.rb})
    watch('db/seeds.rb')
  end
end
