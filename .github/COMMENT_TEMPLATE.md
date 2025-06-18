# Comment Template

To add a comment to a blog post, please follow these steps:

## Step 1: Find the correct comments file
Navigate to `_data/comments/[post-slug].yml` where `[post-slug]` is the slug of the blog post.

## Step 2: Add your comment
Add your comment to the end of the file using this format:

```yaml
- author: Your Name
  date: 2024-01-01T12:00:00Z
  content: Your comment content here. You can write multiple lines and include both English and Chinese text.
```

## Step 3: Submit a Pull Request
1. Fork this repository
2. Edit the comments file
3. Commit your changes with a descriptive message like "Add comment to [post-title]"
4. Submit a pull request

## Guidelines
- Keep comments respectful and constructive
- Both English and Chinese comments are welcome
- Use proper YAML formatting
- Include your actual name or preferred username
- Use ISO 8601 format for dates (YYYY-MM-DDTHH:MM:SSZ)

## Example
```yaml
- author: John Doe
  date: 2024-01-01T12:00:00Z
  content: Great post! I really enjoyed reading about this topic.

- author: 张三
  date: 2024-01-01T13:00:00Z
  content: 非常好的文章！我学到了很多东西。
```

Thank you for contributing to the discussion! 