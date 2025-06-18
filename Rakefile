require 'fileutils'

desc "Process bilingual content for development"
task :process_bilingual do
  puts "🔍 Processing bilingual markdown files for development..."
  
  processed_count = 0
  
  # Find all markdown files with bilingual: true
  Dir.glob("**/*.md").reject { |f| f.start_with?("_site/") || f.start_with?("vendor/") }.each do |file|
    next unless File.exist?(file)
    
    content = File.read(file)
    next unless content.match(/^bilingual:\s*true/m)
    
    puts "📋 Found bilingual file: #{file}"
    
    # Check if file contains :::lang: syntax
    if content.include?(":::lang:")
      puts "🔄 Processing: #{file} (found :::lang: syntax)"
      
      # Create backup
      backup_file = "#{file}.backup"
      FileUtils.cp(file, backup_file)
      
      begin
        # Process the file
        system("ruby scripts/bilingual_preprocessor.rb \"#{file}\"")
        if $?.success?
          puts "  ✅ Successfully processed #{file}"
          processed_count += 1
        else
          puts "  ❌ Failed to process #{file}, restoring backup"
          FileUtils.mv(backup_file, file)
        end
      rescue => e
        puts "  ❌ Error processing #{file}: #{e.message}, restoring backup"
        FileUtils.mv(backup_file, file) if File.exist?(backup_file)
      ensure
        # Clean up backup if processing succeeded
        FileUtils.rm(backup_file) if File.exist?(backup_file)
      end
    else
      puts "  → No :::lang: syntax found in #{file}, skipping"
    end
  end
  
  puts "📊 Processed #{processed_count} bilingual files"
end

desc "Restore original bilingual files from backups"
task :restore_bilingual do
  puts "🔄 Restoring original bilingual files..."
  
  # This task helps restore files to :::lang: syntax for editing
  restored_count = 0
  
  Dir.glob("**/*.md").reject { |f| f.start_with?("_site/") || f.start_with?("vendor/") }.each do |file|
    next unless File.exist?(file)
    
    content = File.read(file)
    next unless content.match(/^bilingual:\s*true/m)
    
    # Check if file has been processed (contains bilingual-post div)
    if content.include?('<div class="bilingual-post"')
      puts "📋 Restoring #{file} to :::lang: syntax"
      
      # Simple restoration - replace HTML structure back to :::lang: syntax
      restored_content = content
        .gsub(/<div class="bilingual-post" markdown="1">\s*/, '')
        .gsub(/<div class="lang-content lang-en" data-lang="en" markdown="1">\s*/, "\n:::lang:en\n\n")
        .gsub(/<div class="lang-content lang-zh" data-lang="zh" markdown="1">\s*/, "\n:::lang:zh\n\n")
        .gsub(/\s*<\/div>\s*<\/div>\s*$/, '')
        .gsub(/\s*<\/div>\s*/, "\n\n:::lang:end\n")
      
      File.write(file, restored_content)
      restored_count += 1
      puts "  ✅ Restored #{file}"
    end
  end
  
  puts "📊 Restored #{restored_count} files to :::lang: syntax"
end

desc "Serve development server with bilingual processing"
task :serve do
  puts "🚀 Starting development server with bilingual processing..."
  
  # Process bilingual content first
  Rake::Task[:process_bilingual].invoke
  
  # Start Jekyll server
  puts "🌐 Starting Jekyll development server..."
  exec "bundle exec jekyll serve --livereload"
end

desc "Build site with bilingual processing"
task :build do
  puts "🏗️ Building site with bilingual processing..."
  
  # Process bilingual content first
  Rake::Task[:process_bilingual].invoke
  
  # Build Jekyll site
  puts "🔨 Building Jekyll site..."
  system "bundle exec jekyll build"
end

desc "Clean processed files and restore to :::lang: syntax"
task :clean do
  puts "🧹 Cleaning processed files..."
  
  # Restore bilingual files
  Rake::Task[:restore_bilingual].invoke
  
  # Clean Jekyll build
  system "bundle exec jekyll clean"
  
  puts "✨ Clean complete - files restored to :::lang: syntax"
end

# Default task
task default: :serve 