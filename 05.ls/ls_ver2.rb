require 'optparse'
require 'debug'

def main
  all_files = get_files_name
  create_and_show_files_list(all_files)
end

def get_files_name
  options = {}
  OptionParser.new do |opt|
    opt.on('-a', '--all', 'do not ignore entries starting with .'){ |v| options[:a] = v }
    opt.on('-r', 'reverse', 'reverse the sort order'){ |v| options[:r] = v }
    opt.parse!(ARGV)
  end

  if options.has_key?(:a)
    Dir.glob("*", File::FNM_DOTMATCH)
  elsif options.has_key?(:r)
    Dir.glob("*").reverse
  else
    Dir.glob("*").sort
  end
end

COLUMN_NUMBER = 3
SPACE = 5

def create_and_show_files_list(all_files)
  display_row_number = (all_files.size.to_f / COLUMN_NUMBER).ceil

  rest_of_row = all_files.size % COLUMN_NUMBER

  max_column_width = all_files.compact.max_by(&:size).size + SPACE
  formatted_content_names = all_files.map {|space| space.to_s.ljust(max_column_width)}
  (display_row_number * COLUMN_NUMBER - all_files.size).times {formatted_content_names.push(nil)} if rest_of_row != 0
  set_of_files_arrays = formatted_content_names.each_slice(display_row_number).to_a

  set_of_files_arrays.transpose.each do |index|
    puts index.join
  end
end

main
