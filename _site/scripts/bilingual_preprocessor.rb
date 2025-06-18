#!/usr/bin/env ruby

# Bilingual Markdown Preprocessor
# Converts user-friendly :::lang:en / :::lang:end syntax to Jekyll-compatible HTML
# Usage: ruby scripts/bilingual_preprocessor.rb input.md output.md

class BilingualStreamingParser
  def initialize(content)
    @content = content
    @position = 0
    @length = content.length
    @result = []
    @current_lang = nil
    @buffer = ""
    @found_language_content = false
  end

  def parse
    puts "Starting streaming parse of #{@length} characters..."
    
    while @position < @length
      char = current_char
      
      if char == ':' && looking_at(':::lang:')
        puts "Found potential marker at position #{@position}"
        handle_language_marker
      else
        @buffer += char
        advance
      end
    end
    
    # Close any open language section
    if @current_lang
      @result << "\n\n</div>\n"
      puts "Closed final language section"
    end
    
    # Add any remaining buffer content
    flush_buffer
    
    puts "Parse complete. Found language content: #{@found_language_content}"
    
    # Wrap in bilingual container if we found language sections
    if @found_language_content
      result = "<div class=\"bilingual-post\" markdown=\"1\">\n\n#{@result.join('')}\n\n</div>"
      puts "Wrapped content in bilingual container"
      result
    else
      puts "No language content found, returning original"
      @content
    end
  end

  private

  def current_char
    return nil if @position >= @length
    @content[@position]
  end

  def advance
    @position += 1
  end

  def looking_at(pattern)
    return false if @position + pattern.length > @length
    @content[@position, pattern.length] == pattern
  end

  def handle_language_marker
    flush_buffer
    marker = read_marker_line
    
    puts "Read marker: '#{marker}'"
    
    if marker == ':::lang:end'
      if @current_lang
        @result << "\n\n</div>\n"
        @current_lang = nil
        puts "Ended language section"
      end
    elsif marker == ':::lang:en'
      start_language_section('en')
    elsif marker == ':::lang:zh'
      start_language_section('zh')
    else
      puts "Unknown marker: #{marker}"
    end
  end

  def start_language_section(lang)
    if @current_lang
      @result << "\n\n</div>\n"
      puts "Closed previous language section"
    end
    
    @result << "\n<div class=\"lang-content lang-#{lang}\" data-lang=\"#{lang}\" markdown=\"1\">\n\n"
    @current_lang = lang
    @found_language_content = true
    
    puts "Started #{lang} section"
  end

  def read_marker_line
    marker = ""
    
    while @position < @length
      char = current_char
      if char == "\n" || char == "\r"
        advance
        if @position < @length && char == "\r" && current_char == "\n"
          advance
        end
        break
      end
      marker += char
      advance
    end
    
    marker.strip
  end

  def flush_buffer
    if !@buffer.empty?
      @result << @buffer
      @buffer = ""
    end
  end
end

# Example usage
if __FILE__ == $0
  if ARGV.length < 1
    puts "Usage: ruby bilingual_preprocessor.rb input.md [output.md]"
    puts ""
    puts "Example input with user-friendly syntax:"
    puts ""
    puts ":::lang:en"
    puts "English content here"
    puts ":::lang:end"
    puts ""
    puts ":::lang:zh"
    puts "中文内容在这里"
    puts ":::lang:end"
    puts ""
    puts "This will be converted to Jekyll-compatible HTML divs."
    exit 1
  end

  input_file = ARGV[0]
  output_file = ARGV[1] || input_file  # In-place processing if no output file specified

  if !File.exist?(input_file)
    puts "Error: Input file '#{input_file}' not found"
    exit 1
  end

  content = File.read(input_file)
  parser = BilingualStreamingParser.new(content)
  processed_content = parser.parse

  File.write(output_file, processed_content)
  puts "Processed content written to: #{output_file}"
end 