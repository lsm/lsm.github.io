<div class="bilingual-post" markdown="1">

# Bilingual Blog Guide

This guide explains how to create bilingual blog posts with a clean, user-friendly syntax.

## User-Friendly Syntax

You can write bilingual content using the clean `
```markdown
---
layout: post
title: "My Bilingual Post"
date: 2024-01-01
bilingual: true
---

This content appears in both languages.






<div class="lang-content lang-en" data-lang="en" markdown="1">


# English Section
This content only appears in English.



</div>

<div class="lang-content lang-zh" data-lang="zh" markdown="1">


# 中文部分
这个内容只在中文中显示。



</div>
This conclusion appears in both languages.
```

## Streaming Parser Implementation

The bilingual system uses a **streaming parser** that processes content character by character (no regex):

### Key Features:
- ✅ **Character-by-character processing** - No regex patterns
- ✅ **Clean syntax** - Just `- ✅ **Language detection** - Automatically detects bilingual content
- ✅ **Proper HTML output** - Generates semantic HTML with language classes

### How It Works:

1. **Streaming Algorithm**: The parser reads each character sequentially
2. **Marker Detection**: When it encounters `:`, it looks ahead for `3. **Language Sections**: Creates proper HTML divs with language attributes
4. **Content Preservation**: All content between markers is preserved exactly

### Preprocessing Script

Use the preprocessing script to convert user-friendly syntax:

```bash
# Convert user-friendly syntax to Jekyll-compatible HTML
ruby scripts/bilingual_preprocessor.rb input.md output.md
```

The script will:
- Parse your markdown character by character
- Convert `- Wrap everything in a bilingual container
- Preserve all your content exactly as written

### Example Workflow:

1. **Write** your post with clean syntax:
   ```markdown
   




<div class="lang-content lang-en" data-lang="en" markdown="1">


English content here



</div>
```

2. **Process** with the streaming parser:
   ```bash
   ruby scripts/bilingual_preprocessor.rb my_post.md
   ```

3. **Result** is Jekyll-compatible HTML:
   ```html
   



<div class="lang-content lang-en" data-lang="en" markdown="1">


English content here



</div>
```

## Benefits of This Approach

### For Authors:
- **Simple syntax** - No HTML knowledge required
- **Natural writing** - Just add language markers
- **Version control friendly** - Clean diffs
- **No learning curve** - Intuitive marker system

### For Developers:
- **No regex** - Streaming character-by-character parsing
- **Reliable** - Handles edge cases gracefully
- **Extensible** - Easy to add new language markers
- **Fast** - Efficient single-pass parsing

### For Readers:
- **Seamless switching** - JavaScript-powered language toggle
- **Persistent preference** - Language choice saved in localStorage
- **Smooth transitions** - No page reloads
- **Semantic HTML** - Proper language attributes for accessibility

## Current Implementation Status

The streaming parser is fully implemented and working. The current setup uses:

- **Working syntax**: HTML divs with `markdown="1"` (currently active)
- **Preprocessing script**: Converts user-friendly syntax to working format
- **Character-by-character parsing**: No regex, pure streaming algorithm

To use the user-friendly syntax in your workflow:
1. Write posts with `2. Run the preprocessing script
3. Commit the processed version to Jekyll

This gives you the best of both worlds: clean authoring experience and reliable Jekyll processing.

## Features

- **Language Toggle**: Readers can switch between English and Chinese versions with a simple button
- **Seamless Switching**: No page reload required, smooth transitions
- **Language Preference**: User's language choice is saved in localStorage
- **Mixed Content**: Support for content that appears in both languages
- **Native Markdown**: Uses Markdown blockquotes with Kramdown attributes - no HTML knowledge required!
- **Responsive Design**: Works on all device sizes

## How to Create a Bilingual Post

### 1. Set the Bilingual Flag

Add `bilingual: true` to your post's front matter:

```yaml
---
layout: post
title: "Your Title - 你的标题"
date: 2024-01-01
slug: your-post-slug
bilingual: true
---
```

### 2. Structure Your Content Using Native Markdown

Use Markdown blockquotes with Kramdown attributes for language-specific content:

```markdown
<!-- Common content that appears in both languages -->
Welcome to this bilingual blog!

<!-- English-specific content using blockquotes -->
> **English**
> 
> ## English Section
> 
> Your English content goes here. You can use:
> - Markdown formatting
> - Lists and headers  
> - Links and images
> - Any standard markdown syntax
> 
> This content is English-only.
{: .lang-content .lang-en data-lang="en"}

<!-- Chinese-specific content using blockquotes -->
> **中文**
> 
> ## 中文部分
> 
> 你的中文内容放在这里。你可以使用：
> - Markdown 格式
> - 列表和标题
> - 链接和图片
> - 任何标准的 markdown 语法
> 
> 这个内容只有中文。
{: .lang-content .lang-zh data-lang="zh"}

<!-- More common content -->
This appears in both languages.

```

### 3. Key Syntax Elements

- **Blockquotes**: Use `>` to create language-specific content blocks
- **Kramdown Attributes**: Use `{: .class-name}` to add CSS classes and attributes
- **Language Classes**: `.lang-content .lang-en` for English, `.lang-content .lang-zh` for Chinese
- **Data Attributes**: `data-lang="en"` and `data-lang="zh"` for JavaScript functionality
- **Container**: Wrap everything in ``

## Example Post Structure

```markdown
---
layout: post
title: "Hello World - 你好，世界"
date: 2024-01-01
slug: hello-world
bilingual: true
---

This introduction appears in both languages.

> **English**
> 
> ## English Content
> This is only visible when English is selected.
{: .lang-content .lang-en data-lang="en"}

> **中文**
> 
> ## 中文内容
> 这只有在选择中文时才可见。
{: .lang-content .lang-zh data-lang="zh"}

This conclusion appears in both languages.

```

## Why This Approach?

### ✅ **Native Markdown Benefits**
- **No HTML required**: Uses standard Markdown blockquotes
- **Kramdown compatible**: Leverages Jekyll's built-in Kramdown processor
- **Semantic**: Blockquotes naturally represent "quoted" or "special" content
- **Readable**: Easy to read and write in plain text
- **Version control friendly**: Clean diffs in git

### ✅ **Compared to Alternatives**
- **Better than HTML divs**: More Markdown-native
- **Better than custom syntax**: No custom plugins required
- **Better than fenced blocks**: Doesn't conflict with code syntax
- **Better than complex processors**: Uses Jekyll's built-in features

## Styling

The language toggle and content sections are styled to match your existing theme. The toggle button appears below the post title and date, and language-specific content fades in/out smoothly when switching.

## Browser Support

The bilingual feature works in all modern browsers and degrades gracefully. If JavaScript is disabled, all content will be visible simultaneously.

## Tips for Writing Bilingual Posts

1. **Plan your structure**: Decide which sections should be language-specific and which should be common
2. **Keep titles bilingual**: Use format like "English Title - 中文标题" 
3. **Test both languages**: Always preview your post in both languages before publishing
4. **Use blockquote headers**: Start each language block with `> **Language Name**`
5. **Consistent attributes**: Always use the correct Kramdown attributes for each language
6. **Wrap in container**: Don't forget the `bilingual-post` wrapper div

## Advanced Usage

### Multiple Language Sections

You can have multiple language-specific sections in one post:

```markdown
> **English - Introduction**
> This is the English introduction.
{: .lang-content .lang-en data-lang="en"}

> **中文 - 介绍**  
> 这是中文介绍。
{: .lang-content .lang-zh data-lang="zh"}

Common content here...

> **English - Conclusion**
> This is the English conclusion.
{: .lang-content .lang-en data-lang="en"}

> **中文 - 结论**
> 这是中文结论。
{: .lang-content .lang-zh data-lang="zh"}
```



</div>