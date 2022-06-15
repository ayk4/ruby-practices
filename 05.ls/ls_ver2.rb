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

MAX_COLUMN_NUMBER = 3

def create_and_show_files_list(all_files)
  columns_number = (all_files.size / MAX_COLUMN_NUMBER).ceil
  all_files.push(nil) while all_files.size % MAX_COLUMN_NUMBER != 0
  file_index = all_files.each_slice(MAX_COLUMN_NUMBER).to_a.transpose

  space = 5
  max_text_length = all_files.compact.max_by(&:size).size + space
  
  file_index.transpose.each do |index| 
    index.each do |file|
      print "#{file}".ljust(max_text_length)
    end
    print  "\n"
  end
end

main
