require "capistrano/upload_task"

set :application, "portal"
set :repository,  "set your repository location here"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# set :pty, true

set :repo_url, "https://github.com/kochetkovandrew/words.git"

namespace :deploy do

  task :start do
  end

  task :stop do
  end

end

namespace :postdeploy do

  task :postdeploy do
    on roles(:app), in: :parallel do |host|
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:migrate"
          execute :touch , "#{File.join(current_path,'tmp','restart.txt')}"
        end
      end
    end
  end

end

after "deploy", "postdeploy:postdeploy"
