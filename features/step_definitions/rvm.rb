require 'metasploit/yard/aruba/rvm_env'

Before do
  @gemsets_to_delete = []
end

Given /^I create a clean gemset "(.*?)"$/ do |gemset|
  run_simple("rvm gemset create #{gemset}")
  @gemsets_to_delete << gemset
end

Given /^I use gemset "(.*?)"$/ do |gemset|
  current_rvm_env_process_name = 'rvm env'
  run_simple(current_rvm_env_process_name)
  current_rvm_env = get_process(current_rvm_env_process_name).stdout
  current_parsed = Metasploit::Yard::Aruba::RvmEnv.parse(current_rvm_env)

  new_rvm_env_process_name = "rvm @#{gemset} do rvm env"
  run_simple(new_rvm_env_process_name)
  new_rvm_env = get_process(new_rvm_env_process_name).stdout
  new_parsed = Metasploit::Yard::Aruba::RvmEnv.parse(new_rvm_env)

  Metasploit::Yard::Aruba::RvmEnv.change(
      from: current_parsed,
      to: new_parsed,
      world: self
  )

  #
  # Remove this gem's bin from path so the gemset is required to declare the gem as a dependency to get access to the
  # bins
  #

  directories = ENV['PATH'].split(File::PATH_SEPARATOR)
  directories.shift
  path = directories.join(File::PATH_SEPARATOR)

  set_env('PATH', path)

  unset_bundler_env_vars
end

After('~@no-clobber') do
  @gemsets_to_delete.each do |gemset|
    # --force to prevent confirmation prompt
    run_simple("rvm gemset delete --force #{gemset}")
  end
end