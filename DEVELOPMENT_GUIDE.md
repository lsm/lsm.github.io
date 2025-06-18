# Development Guide - Bilingual Blog

This guide explains how to develop your bilingual blog locally with proper `
## 🚀 Quick Start

### Install Dependencies
```bash
bundle install
```

### Start Development Server
```bash
rake serve
# or simply: rake (default task)
```

This will:
1. 🔄 Process all bilingual content (convert `2. 🌐 Start Jekyll development server with live reload
3. 📱 Open your site at `http://localhost:4000`

## 📝 Writing Bilingual Content

### 1. Create a New Post
```bash
# Create your post with clean touch _posts/2024-01-04-my-new-post.md
```

### 2. Use the Clean Syntax
```markdown
---
layout: post
title: "My Bilingual Post - 我的双语帖子"
date: 2024-01-04
bilingual: true
---

Introduction text appears in both languages.





:::lang:en

## English Content

Write your English content here using normal markdown.

- List items work
- **Bold text** works
- [Links](https://example.com) work

:::lang:end
:::lang:zh

## 中文内容

在这里写你的中文内容，使用正常的 markdown。

- 列表项目有效
- **粗体文本**有效
- [链接](https://example.com)有效

:::lang:end
Conclusion appears in both languages.
```

### 3. Preview Your Changes
The development server will automatically:
- ✅ Process your `- ✅ Show the bilingual content with working language toggles
- ✅ Reload the page when you save changes

## 🛠 Available Rake Tasks

### Development Tasks

```bash
# Start development server (processes bilingual content first)
rake serve

# Process bilingual content manually
rake process_bilingual

# Build site for production
rake build
```

### Maintenance Tasks

```bash
# Restore files to rake restore_bilingual

# Clean processed files and restore originals
rake clean

# See all available tasks
rake -T
```

## 🔄 Development Workflow

### Daily Development
1. **Start server**: `rake serve`
2. **Edit files**: Use `3. **Preview**: Changes automatically processed and reloaded
4. **Commit**: Commit files with `
### When You Need to Edit Existing Files
If a file has been processed and contains HTML divs:

```bash
# Restore to clean rake restore_bilingual

# Edit your files with clean syntax
# Then restart development server
rake serve
```

## 📁 File States

### Source Files (What You Edit)
```markdown




:::lang:en

English content

:::lang:end
:::lang:zh

中文内容

:::lang:end
```

### Processed Files (What Jekyll Sees)
```html



:::lang:en

English content

:::lang:end
:::lang:zh

中文内容
```

## 🎯 Best Practices

### 1. Always Use Clean Syntax
- ✅ Write with `- ✅ Commit files with `- ❌ Don't commit processed HTML files

### 2. Development Workflow
```bash
# Start development
rake serve

# When done developing
rake clean  # Optional: restore to clean syntax
git add .
git commit -m "feat: add new bilingual post"
git push
```

### 3. Troubleshooting

**Language toggle not working?**
- Make sure you used `bilingual: true` in front matter
- Check that `- Restart development server: `rake serve`

**File looks corrupted?**
```bash
rake restore_bilingual  # Restore to clean syntax
```

**Development server won't start?**
```bash
rake clean              # Clean everything
bundle install          # Reinstall dependencies
rake serve              # Try again
```

## 🚀 Production Deployment

When you push to GitHub:
1. 📤 **Your files** (with `2. 🤖 **GitHub Actions** processes them automatically
3. 🏗️ **Jekyll builds** with processed HTML
4. 🌐 **Site deploys** with working bilingual functionality

No manual processing needed for production!

## 🎉 Summary

- **Write**: Use clean `- **Develop**: `rake serve` handles processing automatically
- **Deploy**: GitHub Actions processes files in production
- **Maintain**: Use `rake clean` and `rake restore_bilingual` as needed

Happy bilingual blogging! 🌍✨