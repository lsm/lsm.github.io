puts "🔌 Loading bilingual preprocessor plugin..."

# Generator to process bilingual excerpts
class BilingualExcerptGenerator < Jekyll::Generator
  def generate(site)
    puts "🔍 Processing bilingual excerpts..."
    
    site.posts.docs.each do |post|
      if post.data['bilingual'] && post.content.include?(":::lang:")
        puts "📝 Processing excerpt for bilingual post: #{post.data['title']}"
        
        # Get the excerpt and modify its content
        excerpt = post.excerpt
        if excerpt
          puts "🔄 Extracting first language section from full post content"
          # Extract from the full post content instead of the truncated excerpt
          extracted_content = extract_first_language_section_for_excerpt(post.content)
          excerpt.content = extracted_content
          puts "✅ Updated excerpt content"
        end
      end
    end
  end
  
  private
  
  def extract_first_language_section_for_excerpt(content)
    puts "🎯 Extracting first line for excerpt"
    puts "🔍 Full content preview: #{content[0, 200].inspect}..."
    
    # Check if content starts with :::lang: syntax
    if content.strip.start_with?(":::lang:")
      puts "📝 Content starts with bilingual syntax, extracting from first language section"
      # Use regex to find first language section
      pattern = /:::lang:(\w+)\s*\n(.*?):::lang:end/m
      matches = content.scan(pattern)
      
      if matches.any?
        first_lang, first_content = matches.first
        puts "📝 Found first language section: #{first_lang}"
        
        # Extract only the first meaningful line
        first_line = extract_first_meaningful_line(first_content)
        puts "✅ Extracted first line: #{first_line.inspect}"
        return first_line
      else
        puts "❌ No language sections found, falling back to manual parsing"
        return extract_first_language_section_manual(content)
      end
    else
      puts "📝 Content has common introduction, extracting first line from beginning"
      # Extract first meaningful line from the beginning of content
      first_line = extract_first_meaningful_line(content)
      puts "✅ Extracted first line: #{first_line.inspect}"
      return first_line
    end
  end
  
  def extract_first_meaningful_line(content)
    puts "🔍 Extracting first meaningful line from content"
    
    lines = content.split("\n")
    
    # Find the first non-empty, non-markdown-header line
    lines.each do |line|
      cleaned_line = line.strip
      
      # Skip empty lines
      next if cleaned_line.empty?
      
      # Skip markdown headers (lines starting with #)
      next if cleaned_line.start_with?('#')
      
      # Skip bilingual markers
      next if cleaned_line.match(/^:::lang:/)
      
      # This is our first meaningful line
      puts "📝 Found first meaningful line: #{cleaned_line.inspect}"
      return cleaned_line
    end
    
    # If no meaningful line found, return first non-empty line
    first_non_empty = lines.find { |line| !line.strip.empty? }
    puts "📝 Fallback to first non-empty line: #{first_non_empty&.strip.inspect}"
    return first_non_empty&.strip || ""
  end
  
  def extract_first_language_section_manual(content)
    puts "🔧 Using manual parsing as fallback"
    lines = content.split("\n")
    in_lang_section = false
    current_lang = nil
    section_content = []
    
    lines.each_with_index do |line, index|
      line_stripped = line.strip
      
      if line_stripped.match(/^:::lang:(\w+)$/)
        if in_lang_section
          # We've hit another language section, return what we have
          puts "🎯 Found another language section, returning current content"
          return section_content.join("\n").strip
        else
          # Start of first language section
          current_lang = $1
          in_lang_section = true
          puts "📝 Started #{current_lang} section at line #{index + 1}"
          next
        end
      elsif line_stripped == ":::lang:end"
        if in_lang_section
          puts "🎯 Found end marker, returning content"
          return section_content.join("\n").strip
        end
      elsif in_lang_section
        # We're inside a language section, collect the content
        section_content << line
      end
    end
    
    # If we reach here and we were in a section, return what we collected
    if in_lang_section && section_content.any?
      puts "🎯 Reached end of content, returning collected content"
      return section_content.join("\n").strip
    end
    
    puts "❌ No language sections found, returning original content"
    return content
  end
end

Jekyll::Hooks.register :posts, :pre_render do |post|
  puts "🔍 Checking post: #{post.data['title']}"
  # Only process posts marked as bilingual
  if post.data['bilingual']
    puts "📋 Post is marked as bilingual"
    puts "📄 Content preview (first 200 chars): #{post.content[0,200].inspect}"
    # Check if content contains :::lang: syntax
    if post.content.include?(":::lang:")
      puts "🔄 Processing bilingual content for: #{post.data['title']}"
      post.content = process_bilingual_content(post.content)
      puts "✅ Finished processing bilingual content"
    else
      puts "❌ No :::lang: syntax found in content"
      puts "🔍 Searching for patterns in content..."
      puts "   - Contains ':::': #{post.content.include?(':::')}"
      puts "   - Contains 'lang:': #{post.content.include?('lang:')}"
      puts "   - Contains ':::lang': #{post.content.include?(':::lang')}"
    end
  else
    puts "❌ Post not marked as bilingual"
  end
end

Jekyll::Hooks.register :pages, :pre_render do |page|
  puts "🔍 Checking page: #{page.data['title'] || page.name}"
  # Only process pages marked as bilingual
  if page.data['bilingual']
    puts "📋 Page is marked as bilingual"
    puts "📄 Content preview (first 200 chars): #{page.content[0,200].inspect}"
    # Check if content contains :::lang: syntax
    if page.content.include?(":::lang:")
      puts "🔄 Processing bilingual content for: #{page.data['title'] || page.name}"
      page.content = process_bilingual_content(page.content)
      puts "✅ Finished processing bilingual content"
    else
      puts "❌ No :::lang: syntax found in content"
      puts "🔍 Searching for patterns in content..."
      puts "   - Contains ':::': #{page.content.include?(':::')}"
      puts "   - Contains 'lang:': #{page.content.include?('lang:')}"
      puts "   - Contains ':::lang': #{page.content.include?(':::lang')}"
    end
  else
    puts "❌ Page not marked as bilingual"
  end
end

def process_bilingual_content(content)
  puts "🚀 Starting bilingual content processing..."
  result = []
  position = 0
  length = content.length
  current_lang = nil
  buffer = ""
  found_language_content = false
  
  while position < length
    # Check if we're at the start of a :::lang: marker
    if position <= length - 8 && content[position, 8] == ':::lang:'
      puts "🎯 Found :::lang: marker at position #{position}"
      # Flush buffer
      result << buffer unless buffer.empty?
      buffer = ""
      
      # Read the full marker line
      marker_start = position
      while position < length && content[position] != "\n" && content[position] != "\r"
        position += 1
      end
      
      marker = content[marker_start, position - marker_start].strip
      puts "📝 Processing marker: #{marker}"
      
      # Skip the newline
      if position < length && content[position] == "\r"
        position += 1
      end
      if position < length && content[position] == "\n"
        position += 1
      end
      
      if marker == ':::lang:end'
        if current_lang
          result << "\n\n</div>\n"
          current_lang = nil
          puts "🔚 Ended language section"
        end
      elsif marker == ':::lang:en'
        if current_lang
          result << "\n\n</div>\n"
        end
        result << "\n<div class=\"lang-content lang-en\" data-lang=\"en\" markdown=\"1\">\n\n"
        current_lang = 'en'
        found_language_content = true
        puts "🇺🇸 Started English section"
      elsif marker == ':::lang:zh'
        if current_lang
          result << "\n\n</div>\n"
        end
        result << "\n<div class=\"lang-content lang-zh\" data-lang=\"zh\" markdown=\"1\">\n\n"
        current_lang = 'zh'
        found_language_content = true
        puts "🇨🇳 Started Chinese section"
      else
        # Unknown marker, add it back
        buffer += marker + "\n"
        puts "❓ Unknown marker: #{marker}"
      end
    else
      buffer += content[position]
      position += 1
    end
  end
  
  # Close any open language section
  if current_lang
    result << "\n\n</div>\n"
    puts "🔚 Closed final language section"
  end
  
  # Add any remaining buffer content
  result << buffer unless buffer.empty?
  
  # Wrap in bilingual container if we found language sections
  if found_language_content
    processed_content = "<div class=\"bilingual-post\" markdown=\"1\">\n\n#{result.join('')}\n\n</div>"
    puts "📦 Wrapped content in bilingual container"
    processed_content
  else
    puts "❌ No language content found, returning original"
    content
  end
end

puts "✅ Bilingual preprocessor plugin loaded successfully" 