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
    #オプションをここに追加していく予定です
    opt.parse!(ARGV)
  end

  if options.has_key?(:a)
    Dir.glob("*", File::FNM_DOTMATCH)
  else
    Dir.glob("*").sort
  end
end

COLUMN_NUMBER = 3
SPACE = 5

def create_and_show_files_list(all_files)
  row = (all_files.size.to_f / COLUMN_NUMBER).ceil

  rest_of_row = all_files.size % COLUMN_NUMBER

  max_text_length = all_files.compact.max_by(&:size).size + SPACE
  formd_file = all_files.map {|space| space.to_s.ljust(max_text_length)}
  (row * COLUMN_NUMBER - all_files.size).times {formd_file.push(nil)} if rest_of_row != 0
  file_index = formd_file.each_slice(row).to_a

  file_index.transpose.each do |index|
    puts index.join
  end
end

main
