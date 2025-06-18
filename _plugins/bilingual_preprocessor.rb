# Bilingual Content Preprocessor Plugin for Jekyll
# Automatically converts :::lang:en / :::lang:zh / :::lang:end syntax to HTML divs
# This allows users to write bilingual content naturally without manual preprocessing

# Load the streaming parser class
require 'pathname'

# Define the BilingualStreamingParser class directly in the plugin
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
    while @position < @length
      char = current_char
      
      if char == ':' && looking_at(':::lang:')
        handle_language_marker
      else
        @buffer += char
        advance
      end
    end
    
    # Close any open language section
    if @current_lang
      @result << "\n\n</div>\n"
    end
    
    # Add any remaining buffer content
    flush_buffer
    
    # Wrap in bilingual container if we found language sections
    if @found_language_content
      result = "<div class=\"bilingual-post\" markdown=\"1\">\n\n#{@result.join('')}\n\n</div>"
      result
    else
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
    
    if marker == ':::lang:end'
      if @current_lang
        @result << "\n\n</div>\n"
        @current_lang = nil
      end
    elsif marker == ':::lang:en'
      start_language_section('en')
    elsif marker == ':::lang:zh'
      start_language_section('zh')
    end
  end

  def start_language_section(lang)
    if @current_lang
      @result << "\n\n</div>\n"
    end
    
    @result << "\n<div class=\"lang-content lang-#{lang}\" data-lang=\"#{lang}\" markdown=\"1\">\n\n"
    @current_lang = lang
    @found_language_content = true
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

module Jekyll
  class BilingualPreprocessor < Generator
    safe true
    priority :high
    
    def generate(site)
      Jekyll.logger.info "Bilingual Preprocessor:", "Starting preprocessing..."
      
      # Process all documents (posts, pages, etc.)
      all_docs = site.documents + site.pages
      
      processed_count = 0
      
      all_docs.each do |doc|
        # Only process documents that are marked as bilingual
        next unless doc.data['bilingual']
        
        Jekyll.logger.info "Bilingual Preprocessor:", "Processing #{doc.relative_path || doc.name}"
        
        # Use the streaming parser to convert the content
        parser = BilingualStreamingParser.new(doc.content)
        processed_content = parser.parse
        
        # Update the document content with the processed version
        doc.content = processed_content
        
        processed_count += 1
        Jekyll.logger.debug "Bilingual Preprocessor:", "Processed content length: #{processed_content.length} characters"
      end
      
      Jekyll.logger.info "Bilingual Preprocessor:", "Processed #{processed_count} bilingual documents"
    end
  end
end 