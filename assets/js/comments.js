// Comments loader
document.addEventListener('DOMContentLoaded', () => {
    const commentsContainer = document.getElementById('comments-container');
    const commentsDataElement = document.getElementById('comments-data');
    
    let comments = [];
    
    // Try to get comments from embedded JSON data
    if (commentsDataElement) {
        try {
            const commentsText = commentsDataElement.textContent.trim();
            if (commentsText && commentsText !== 'null' && commentsText !== '') {
                comments = JSON.parse(commentsText);
            }
        } catch (error) {
            console.log('Error parsing comments data:', error);
        }
    }
    
    displayComments(comments);

    function displayComments(comments) {
        if (!comments || comments.length === 0) {
            commentsContainer.innerHTML = `
                <p class="no-comments">No comments yet. Be the first to comment!</p>
                <p class="no-comments zh">还没有评论。成为第一个评论的人吧！</p>
            `;
            return;
        }

        const commentsList = comments.map(comment => {
            const date = comment.date ? new Date(comment.date) : new Date();
            const formattedDate = date.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
            
            return `
                <div class="comment">
                    <div class="comment-header">
                        <strong class="comment-author">${escapeHtml(comment.author)}</strong>
                        <time class="comment-date" datetime="${comment.date}">${formattedDate}</time>
                    </div>
                    <div class="comment-content">
                        ${escapeHtml(comment.content).replace(/\n/g, '<br>')}
                    </div>
                </div>
            `;
        }).join('');

        commentsContainer.innerHTML = commentsList;
    }



    function escapeHtml(unsafe) {
        if (!unsafe) return '';
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
});