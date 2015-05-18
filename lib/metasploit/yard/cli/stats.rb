# Extends `YARD::CLI::Stats` to not mark writers as undocuments for instance attributes.
class Metasploit::Yard::CLI::Stats < ::YARD::CLI::Stats
  # Statistics for methods
  def stats_for_methods
    objs = all_objects.select {|m| m.type == :method }
    objs.reject! {|m| m.is_alias? }
    undoc = objs.select { |m|
      m.docstring.blank? && !(m.writer? && m.is_attribute?)
    }
    @undoc_list |= undoc if @undoc_list
    output "Methods", objs.size, undoc.size
  end
end