const CACHE_NAME = 'flutter-app-cache-v1.01';
const API_CACHE_NAME = 'api-cache-v1.01';
const API_URL_PREFIX = 'https://www.hously.cloud/';
const resourcesToCache = [
  '/', // Strona główna
  '/index.html',
  '/main.dart.js',
  '/manifest.json',
  '/canvaskit.wasm',
  '/canvaskit.js',
  '/favicon.png',
  '/icons/Icon-192.png',
  '/icons/Icon-512.png',
  '/content.css',
  // Dodaj więcej zasobów aplikacji tutaj
];

// Instalacja Service Workera
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(resourcesToCache);
    })
  );
});

// Aktywacja Service Workera
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keyList) => {
      return Promise.all(
        keyList.map((key) => {
          if (key !== CACHE_NAME && key !== API_CACHE_NAME) {
            return caches.delete(key);
          }
        })
      );
    })
  );
  return self.clients.claim();
});

// Obsługa żądań
self.addEventListener('fetch', (event) => {
  const requestUrl = new URL(event.request.url);

  // Obsługa API
  if (requestUrl.href.startsWith(API_URL_PREFIX)) {
    event.respondWith(
      fetch(event.request)
        .then((response) => {
          // Zapisz odpowiedź API do cache
          return caches.open(API_CACHE_NAME).then((cache) => {
            cache.put(event.request, response.clone());
            return response;
          });
        })
        .catch(() => {
          // W przypadku braku sieci zwróć odpowiedź z cache
          return caches.match(event.request);
        })
    );
    return;
  }

  // Ignorowanie ponownego pobierania statycznych zasobów
  if (resourcesToCache.some((resource) => requestUrl.pathname.endsWith(resource))) {
    event.respondWith(fetch(event.request, { cache: 'only-if-cached', mode: 'same-origin' }));
    return;
  }

  // Buforowanie innych zasobów aplikacji
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});
