namespace :dev do
  desc 'Start the debugger'
  task :debug do
    exec 'bundle exec rdbg -a'
  end
end
