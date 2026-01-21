// Optimized vanilla JavaScript to replace jQuery
(function() {
    'use strict';
    
    function ready(fn) {
        if (document.readyState !== 'loading') {
            fn();
        } else {
            document.addEventListener('DOMContentLoaded', fn);
        }
    }
    
    function slideUp(element, duration = 300) {
        element.style.transition = `height ${duration}ms ease-in-out`;
        element.style.height = element.offsetHeight + 'px';
        element.offsetHeight; // Force reflow
        element.style.height = '0px';
        element.style.overflow = 'hidden';
        
        setTimeout(() => {
            element.style.display = 'none';
            element.style.height = '';
            element.style.overflow = '';
            element.style.transition = '';
        }, duration);
    }
    
    function slideDown(element, duration = 300) {
        element.style.display = 'block';
        const height = element.scrollHeight + 'px';
        element.style.height = '0px';
        element.style.overflow = 'hidden';
        element.style.transition = `height ${duration}ms ease-in-out`;
        element.offsetHeight; // Force reflow
        element.style.height = height;
        
        setTimeout(() => {
            element.style.height = '';
            element.style.overflow = '';
            element.style.transition = '';
        }, duration);
    }
    
    function isHidden(element) {
        return element.style.display === 'none' || 
               getComputedStyle(element).display === 'none';
    }
    
    ready(function() {
        const delay = 300;
        
        // Hide all episode content except the first one
        const episodeContents = document.querySelectorAll('div.EpisodeContent');
        episodeContents.forEach((content, index) => {
            if (index > 0) {
                content.style.display = 'none';
            }
        });
        
        // Set correct expand/collapse icons
        const colExpIcons = document.querySelectorAll('img.ColExpIcon');
        colExpIcons.forEach((icon, index) => {
            icon.src = index === 0 ? 'images/collapse.png' : 'images/expand.png';
        });
        
        // Set cursor style for episode headers
        const headings = document.querySelectorAll('h3.Heading');
        headings.forEach(heading => {
            heading.style.cursor = 'pointer';
        });
        
        // Handle clicks on episode titles
        headings.forEach(heading => {
            heading.addEventListener('click', function() {
                const contentId = '#Content-' + this.id;
                const iconId = 'ColExp-' + this.id;
                
                const contentElement = document.querySelector(contentId);
                const iconElement = document.getElementById(iconId);
                
                if (!contentElement || !iconElement) return;
                
                if (isHidden(contentElement)) {
                    slideDown(contentElement, delay);
                    iconElement.src = 'images/collapse.png';
                } else {
                    slideUp(contentElement, delay);
                    iconElement.src = 'images/expand.png';
                }
            });
        });
    });
})();