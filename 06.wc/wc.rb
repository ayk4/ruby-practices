# frozen_string_literal: true

require 'optparse'

def main
  print_result(**option_parse)
end

def print_result(**options)
  file_name = ARGV[0]
  text = IO.read(file_name)

  print_newline_counts = newline_counts(text) if options[:l] || options.empty?
  print_word_count = word_counts(text) if options[:w] || options.empty?
  print_byte_count = byte_count(text) if options[:c] || options.empty?
  print_file_name = file_name unless options.empty?

  print "#{print_newline_counts} #{print_word_count} #{print_byte_count} #{print_file_name} \n"
end

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

def newline_counts(text)
  text.count("\n").to_s.rjust(7)
end

def word_counts(text)
  text.split.count.to_s.rjust(7)
end

def byte_count(text)
  text.bytesize.to_s.rjust(7)
end

main
