# Automated Bilingual Content System

This guide explains the automated bilingual content processing system using GitHub Actions and Jekyll for your blog.

## 🎯 The Solution: GitHub Actions Automation

The system automatically converts user-friendly `
## ✨ How It Works

### 1. **Write Content Naturally**
```markdown
---
layout: post
title: "My Bilingual Post"
bilingual: true
---

Introduction text appears in both languages.





:::lang:en

English content here.
- Easy to write
- Clean syntax

:::lang:end
:::lang:zh

中文内容在这里。
- 易于编写
- 清洁语法

:::lang:end
Conclusion appears in both languages.
```

### 2. **GitHub Actions Processes Automatically**
When you push to GitHub, the workflow:
- 🔍 Finds all markdown files with `bilingual: true`
- 🔄 Converts `- 📝 Commits the processed files back to the repository
- 🚀 Triggers GitHub Pages to rebuild with proper HTML

### 3. **Result: Perfect HTML Structure**
```html



:::lang:en

English content here.
- Easy to write
- Clean syntax

:::lang:end
:::lang:zh

中文内容在这里。
- 易于编写
- 清洁语法
```

## 🚀 Getting Started

### Step 1: Enable the Workflow
The GitHub Actions workflow is already set up in `.github/workflows/process-bilingual.yml`. It automatically runs when you push markdown files.

### Step 2: Create Bilingual Content
1. Add `bilingual: true` to your post's front matter
2. Use the `3. Push to GitHub
4. The workflow automatically processes your content!

### Step 3: Language Switching
The bilingual system includes:
- **Main language toggle**: Top-right corner of posts
- **Comment section toggle**: Separate toggle for comment instructions
- **Automatic language detection**: Remembers user preference

## 📝 Syntax Reference

### Basic Structure
```markdown
---
bilingual: true  # Required for processing
---

Shared content (appears in both languages)

:::lang:end
:::lang:en

English-only content

:::lang:end
:::lang:zh

Chinese-only content

:::lang:end
More shared content
```

### Supported Languages
- `- `- `
### Nesting and Markdown
All standard markdown works inside language blocks:
```markdown




:::lang:en

## English Heading

- List items
- **Bold text**
- [Links](https://example.com)

> Blockquotes work too!

```code blocks```

:::lang:end
```

## 🔧 Technical Details

### GitHub Actions Workflow
- **Trigger**: Push to main branch with markdown file changes
- **Process**: Finds bilingual files, processes syntax, commits results
- **Safety**: Creates backups, restores on failure
- **Performance**: Only processes files with `
### File Processing
- **In-place editing**: Modifies original files directly
- **Preserves formatting**: Maintains markdown structure
- **Error handling**: Restores backups on processing errors
- **Commit messages**: Descriptive, includes `[skip ci]` to prevent loops

### Jekyll Integration
- **GitHub Pages compatible**: No custom plugins required
- **CSS/JS ready**: Works with existing bilingual styling
- **SEO friendly**: Proper HTML structure for search engines

## 🎨 Styling and Behavior

### CSS Classes Generated
- `.bilingual-post` - Container for bilingual content
- `.lang-content` - Individual language sections
- `.lang-en` / `.lang-zh` - Language-specific styling
- `data-lang` attributes for JavaScript targeting

### JavaScript Integration
The system works with existing JavaScript:
- Language toggle functionality
- User preference storage
- Smooth transitions between languages

## 🛠 Customization

### Adding New Languages
To support additional languages:

1. **Update the preprocessor** (`scripts/bilingual_preprocessor.rb`):
```ruby
elsif marker == '  start_language_section('fr')
```

2. **Update CSS** (`assets/css/custom.css`):
```css
html[data-lang="fr"] .lang-fr {
    display: block !important;
}
```

3. **Update JavaScript** (`assets/js/main.js`):
```javascript
// Add French language support
```

### Workflow Customization
Edit `.github/workflows/process-bilingual.yml` to:
- Change trigger conditions
- Modify processing paths
- Add additional validation steps
- Customize commit messages

## 🔍 Troubleshooting

### Common Issues

**Workflow not running?**
- Check that files have `bilingual: true` in front matter
- Ensure you're pushing to the main branch
- Verify the workflow file is in `.github/workflows/`

**Content not processing?**
- Confirm `- Check for typos in language codes
- Ensure `
**Language switching not working?**
- Verify HTML structure was generated correctly
- Check browser console for JavaScript errors
- Ensure CSS classes are properly applied

### Debug Mode
Enable debug output by adding `debug: true` to your post's front matter. This will show processing details in the workflow logs.

## 📊 Benefits

### For Content Creators
- ✅ **Natural writing experience**: No HTML required
- ✅ **Real-time preview**: Standard markdown editors work
- ✅ **Error prevention**: Automatic syntax validation
- ✅ **Version control friendly**: Clean diffs in git

### For Developers
- ✅ **GitHub Pages compatible**: No plugin restrictions
- ✅ **Automated processing**: Zero manual intervention
- ✅ **Extensible**: Easy to add new languages
- ✅ **Reliable**: Robust error handling and backups

### For Readers
- ✅ **Seamless experience**: Smooth language switching
- ✅ **Fast loading**: Optimized HTML structure
- ✅ **Accessible**: Proper semantic markup
- ✅ **Mobile friendly**: Responsive design

## 🚀 Next Steps

1. **Try it out**: Create a test post with bilingual content
2. **Customize styling**: Modify CSS for your design preferences
3. **Add languages**: Extend support for additional languages
4. **Monitor workflow**: Check GitHub Actions for processing logs

The automated bilingual system makes it effortless to create multilingual content while maintaining full compatibility with GitHub Pages! 🎉

:::lang:end
