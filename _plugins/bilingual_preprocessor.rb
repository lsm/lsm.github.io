puts "🔌 Loading bilingual preprocessor plugin..."

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