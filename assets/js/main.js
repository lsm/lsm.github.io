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
    
    // Check for saved language preference or default to 'en'
    const savedLang = localStorage.getItem('blog-language') || 'en';
    
    // Initialize language display
    switchLanguage(savedLang);
    updateToggleButton(savedLang);
    
    // Add click event to language toggle
    langToggle.addEventListener('click', () => {
        const currentLang = document.documentElement.getAttribute('data-lang') || 'en';
        const newLang = currentLang === 'en' ? 'zh' : 'en';
        
        switchLanguage(newLang);
        updateToggleButton(newLang);
        localStorage.setItem('blog-language', newLang);
    });
    
    function switchLanguage(lang) {
        document.documentElement.setAttribute('data-lang', lang);
        
        // Hide all language content
        const allLangContent = document.querySelectorAll('.lang-content');
        allLangContent.forEach(content => {
            content.style.display = 'none';
        });
        
        // Show content for selected language
        const selectedLangContent = document.querySelectorAll(`.lang-${lang}`);
        selectedLangContent.forEach(content => {
            content.style.display = 'block';
        });
    }
    
    function updateToggleButton(activeLang) {
        const langOptions = langToggle.querySelectorAll('.lang-option');
        langOptions.forEach(option => {
            if (option.dataset.lang === activeLang) {
                option.classList.add('active');
            } else {
                option.classList.remove('active');
            }
        });
    }
});
