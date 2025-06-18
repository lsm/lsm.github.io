# Bilingual Blog

A minimalist bilingual blog built with Jekyll for GitHub Pages.

## Features
- Bilingual support (English & Chinese)
- Minimalist black & white theme with dark mode
- PR-based commenting system
- Custom Chinese font (Noto Serif SC)

## Deployment to GitHub Pages

1. Create a new repository on GitHub
2. Push this code to the repository
3. Go to repository Settings > Pages
4. Under "Source", select the main branch
5. Your site will be published at `https://[username].github.io/[repository]`

## Local Development

```bash
bundle install
bundle exec jekyll serve
```

## Adding Comments via Pull Requests

This blog features a **PR-based commenting system** where comments are stored as YAML files and submitted via GitHub pull requests.

### How it works:
1. **Comments are stored** in `_data/comments/[post-slug].yml`
2. **Users can comment** by editing these files directly on GitHub
3. **Pull requests are reviewed** and merged to publish comments
4. **Comments appear automatically** on the blog after merge

### For commenters:
1. Click the "Edit the comments file directly on GitHub" link on any blog post
2. Add your comment using the YAML format:
   ```yaml
   - author: Your Name
     date: 2024-01-01T12:00:00Z
     content: Your comment here
   ```
3. Submit a pull request
4. Your comment will appear after review and merge

### Features:
- ✅ **Bilingual support** - Comments in English and Chinese
- ✅ **Spam protection** - All comments reviewed before publishing
- ✅ **Version control** - Full history of all comments
- ✅ **No external dependencies** - Pure Jekyll/GitHub Pages
- ✅ **Automatic validation** - GitHub Actions validate comment format
- ✅ **Beautiful UI** - Responsive design with dark mode support

See [Comment Template](.github/COMMENT_TEMPLATE.md) for detailed guidelines.

## License

MIT
