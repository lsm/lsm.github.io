// Theme switcher
document.addEventListener('DOMContentLoaded', () => {
    const themeToggle = document.getElementById('theme-toggle');
    const sunIcon = document.getElementById('sun-icon');
    const moonIcon = document.getElementById('moon-icon');
    
    // Check for saved theme preference or default to 'dark'
    const savedTheme = localStorage.getItem('theme') || 'dark';
    document.documentElement.setAttribute('data-theme', savedTheme);

    // Set the initial icon based on the saved theme
    if (savedTheme === 'light') {
        sunIcon.style.display = 'none';
        moonIcon.style.display = 'inline';
    } else {
        sunIcon.style.display = 'inline';
        moonIcon.style.display = 'none';
    }

    themeToggle.addEventListener('click', () => {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);

        if (newTheme === 'light') {
            sunIcon.style.display = 'none';
            moonIcon.style.display = 'inline';
        } else {
            sunIcon.style.display = 'inline';
            moonIcon.style.display = 'none';
        }
    });
});

// Language switcher for bilingual posts
document.addEventListener('DOMContentLoaded', () => {
    const langToggle = document.getElementById('lang-toggle');
    const bilingualPost = document.querySelector('.bilingual-post');
    
    if (!langToggle || !bilingualPost) return;
    
    // Add click event to language toggle
    langToggle.addEventListener('click', (e) => {
        e.preventDefault();
        const currentLang = document.documentElement.getAttribute('data-lang') || 'en';
        const newLang = currentLang === 'en' ? 'zh' : 'en';
        
        switchLanguage(newLang);
        localStorage.setItem('blog-language', newLang);
    });
    
    function switchLanguage(lang) {
        document.documentElement.setAttribute('data-lang', lang);
    }
});
