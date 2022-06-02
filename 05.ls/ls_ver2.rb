require 'optparse'
require 'debug'

def main
  current_dir = get_deta
  arrays = make_array(current_dir)
  show_files(arrays)
end

def get_deta
  @options = {}
  OptionParser.new do |opt|
    opt.on('-a', '--all', 'do not ignore entries starting with .'){ |v| @options[:a] = v }
    #オプションをここに追加していく予定です
    opt.parse!(ARGV)
  end

  if @options.has_key?(:a)
    Dir.glob("*", File::FNM_DOTMATCH)
  else
    Dir.glob("*").sort
  end
end

MAX_ROW = 3.0
def make_array(current_dir)
  total_file_size = current_dir.size
  columns = (total_file_size / MAX_ROW).ceil
  arrays = []
  if total_file_size.zero?
    arrays
  else
    current_dir.each_slice(columns) do |list_of_file|
      arrays << list_of_file
    end
    max_size = arrays.map(&:size).max
    arrays.map! { |element| element.values_at(0...max_size) }
  end
end

def show_files(arrays)
  transposed_array = arrays.transpose
  transposed_array.each do |two_dimensional_array|
    two_dimensional_array.each do |file|
      print "#{file}".ljust(25)
    end
    print  "\n"
  end
end

main
