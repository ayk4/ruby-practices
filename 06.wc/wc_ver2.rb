# frozen_string_literal: true

require 'optparse'
require 'readline'

def main
  options = option_parse
  options = { l: true, w: true, c: true } if options.empty?
  
  # 引数の有無を確認する。引数がないときには？
  if ARGV.empty?
    # 引数なし
    read_pipe = $stdin.read
    print_argv_deta(read_pipe, options)
  else
    #引数あり
    argument_deta = get_files_data(ARGV)
    print_argv_deta(argument_deta, options)
    print_total(file) if ARGV.size > 1
  end
end

# オプションを追加
def option_parse
  options = {}
  OptionParser.new do |opt|
    opt.on('-l', '--lines', 'print the newline counts') { |v| options[:l] = v }
    opt.on('-w', '--words', 'print the word counts') { |v| options[:w] = v }
    opt.on('-c', '--bytes', 'print the byte counts') { |v| options[:c] = v }
    opt.parse!(ARGV)
  end
  options
end

def get_files_data(files_path)
  files_path.map do |file_path|
    content = nil
    File.open(file_path) do |file|
      content = file.read
    end
    {
      name: file_path,
      content:
    }
  end
end


