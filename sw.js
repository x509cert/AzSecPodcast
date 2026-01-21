// Service Worker for Azure Security Podcast - Aggressive Caching Strategy
const CACHE_NAME = 'azsec-podcast-v1';
const STATIC_CACHE_URLS = [
    '/',
    '/index.html',
    '/css/optimized.css',
    '/js/ui-optimized.js',
    '/images/favicon-aznew.ico',
    '/images/apple_podcasts_badge1.png',
    '/images/listen-on-spotify-badge-300x92.jpg',
    '/images/rss-button.png',
    '/images/AmznPodcast.png',
    '/images/Collapse.png',
    '/images/Expand.png'
];

// Install event - cache static resources
self.addEventListener('install', event => {
    event.waitUntil(
        caches.open(CACHE_NAME).then(cache => {
            return cache.addAll(STATIC_CACHE_URLS);
        })
    );
    self.skipWaiting();
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
    event.waitUntil(
        caches.keys().then(cacheNames => {
            return Promise.all(
                cacheNames.map(cacheName => {
                    if (cacheName !== CACHE_NAME) {
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
    self.clients.claim();
});

// Fetch event - serve from cache first, then network
self.addEventListener('fetch', event => {
    // Skip non-GET requests
    if (event.request.method !== 'GET') return;
    
    // Skip external requests (CDN, analytics, etc.)
    if (!event.request.url.startsWith(self.location.origin)) return;
    
    event.respondWith(
        caches.match(event.request).then(cachedResponse => {
            if (cachedResponse) {
                return cachedResponse;
            }
            
            return fetch(event.request).then(response => {
                // Don't cache non-successful responses
                if (!response || response.status !== 200 || response.type !== 'basic') {
                    return response;
                }
                
                // Clone the response because it's a stream
                const responseToCache = response.clone();
                
                caches.open(CACHE_NAME).then(cache => {
                    cache.put(event.request, responseToCache);
                });
                
                return response;
            });
        })
    );
});