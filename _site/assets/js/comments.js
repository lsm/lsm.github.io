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
            let formattedDate = 'Unknown date';
            
            if (comment.date) {
                try {
                    // Handle different date formats
                    let dateObj;
                    if (typeof comment.date === 'string') {
                        // Try parsing ISO format first
                        dateObj = new Date(comment.date);
                        // If that fails, try other common formats
                        if (isNaN(dateObj.getTime())) {
                            // Try parsing as YYYY-MM-DD HH:MM:SS format
                            const dateStr = comment.date.replace(/(\d{4}-\d{2}-\d{2})\s+(\d{2}:\d{2}:\d{2})/, '$1T$2');
                            dateObj = new Date(dateStr);
                        }
                    } else {
                        dateObj = new Date(comment.date);
                    }
                    
                    if (!isNaN(dateObj.getTime())) {
                        formattedDate = dateObj.toLocaleDateString('en-US', {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric'
                        });
                    }
                } catch (error) {
                    console.log('Error parsing date:', comment.date, error);
                }
            }
            
            return `
                <div class="comment">
                    <div class="comment-header">
                        <strong class="comment-author">${escapeHtml(comment.author)}</strong>
                        <time class="comment-date" datetime="${comment.date || ''}">${formattedDate}</time>
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