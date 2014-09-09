Given(/^I install the project gem locally$/) do
  process_name = "gem build metasploit-yard.gemspec"
  root = Pathname.new(__FILE__).parent.parent.parent
  current_pathname = Pathname.new(current_dir).expand_path
  root_relative_to_current = root.relative_path_from(current_pathname)
  current_relative_to_root = current_pathname.relative_path_from(root)

  cd(root_relative_to_current)
  run_simple(process_name)
  cd(current_relative_to_root)

  gem_build_output = get_process(process_name).output
  match = gem_build_output.match(/^  File: (?<gem_file>.*)$/)

  unless match
    fail "Cannot parse gem build output for built gem name:\n#{gem_build_output}"
  end

  # need to include root as this is back in tmp/aruba
  gem_pathname = root.join(match[:gem_file])

  run_simple("gem install #{gem_pathname}")

  gem_pathname.delete
end