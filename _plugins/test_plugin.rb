puts "🧪 TEST PLUGIN LOADED SUCCESSFULLY!"

Jekyll::Hooks.register :site, :after_init do |site|
  puts "🧪 TEST PLUGIN: Site initialized!"
end 