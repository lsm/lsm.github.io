// Comments loader
document.addEventListener('DOMContentLoaded', () => {
    const commentsContainer = document.getElementById('comments-container');
    const postPath = window.location.pathname;
    const postSlug = postPath.replace(/\/$/, '').split('/').pop();

    // Fetch comments from _data/comments/
    fetch(`/_data/comments/${postSlug}.yml`)
        .then(response => response.text())
        .then(yaml => {
            // Parse YAML to get comments
            const comments = parseYaml(yaml);
            displayComments(comments);
        })
        .catch(error => {
            commentsContainer.innerHTML = '<p>No comments yet. Be the first to comment!</p>';
        });

    function displayComments(comments) {
        if (!comments || comments.length === 0) {
            commentsContainer.innerHTML = '<p>No comments yet. Be the first to comment!</p>';
            return;
        }

        const commentsList = comments.map(comment => `
            <div class="comment">
                <div class="comment-header">
                    <strong>${escapeHtml(comment.author)}</strong>
                    <time>${new Date(comment.date).toLocaleDateString()}</time>
                </div>
                <div class="comment-content">
                    ${escapeHtml(comment.content)}
                </div>
            </div>
        `).join('');

        commentsContainer.innerHTML = commentsList;
    }

    function escapeHtml(unsafe) {
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
});