# @note All options not specific to any given rake task should go in the .yardopts file so they are available to both
#   the below rake tasks and when invoking `yard` from the command line

#
# Gems
#
# gems must load explicitly any gem declared in gemspec
# @see https://github.com/bundler/bundler/issues/2018#issuecomment-6819359
#
#

require 'yard'

namespace :yard do
  YARD::Rake::YardocTask.new(:doc) do |t|
    # --no-stats here as 'stats' task called after will print fuller stats
    t.options = ['--no-stats']

    t.after = Proc.new {
      Rake::Task['yard:stats'].execute
    }
  end

  desc "Shows stats for YARD Documentation including listing undocumented modules, classes, constants, and methods"
  task :stats => :environment do
    require 'metasploit/yard'
    stats = Metasploit::Yard::CLI::Stats.new
    stats.run('--compact', '--list-undoc')

    threshold = 100.0
    threshold_path = 'config/yard-stats-threshold'

    if File.exist?(threshold_path)
      threshold = File.read(threshold_path).to_f
    end

    # duplicates end of YARD::CLI::Stats#print_statistics
    # @see https://github.com/lsegal/yard/blob/76c7525f46df38f7b24d4b3cb9daeef512fe58e8/lib/yard/cli/stats.rb#L63-L69
    total = stats.instance_eval {
      if @undocumented == 0
        100
      elsif @total == 0
        0
      else
        (@total - @undocumented).to_f / @total.to_f * 100
      end
    }

    if total < threshold
      $stderr.puts "Documentation percentage (%<total>.2f%%) below threshold (%<threshold>.2f%%)" % { total: total, threshold: threshold}
      exit 1
    end
  end
end

task :environment do
  # stub task for when not run in a Rails project
end

# @todo Figure out how to just clone description from yard:doc
desc "Generate YARD documentation"
# allow calling namespace to as a task that goes to default task for namespace
task :yard => ['yard:doc']
