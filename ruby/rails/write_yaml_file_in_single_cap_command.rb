set :yaml, "a:\\n  one: 'a value'\\n  two: 'another value'\\nb:\\n  three: 'last value'\\n"

namespace :post_deploy do
 
  task :write_some_config_file do
    sudo "echo -e \"#{yaml}\" > #{current_path}/config/a_configfile.yml"
  end
end