importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js');

// Your Firebase config
const firebaseConfig = {
 apiKey: 'AIzaSyBTcKfCA26Ho_DmzJzXRQL0DV8vg0fOAps',
   authDomain: 'hously-ai-5b29c.firebaseapp.com',
   projectId: 'hously-ai-5b29c',
   storageBucket: 'hously-ai-5b29c.firebasestorage.app',
   messagingSenderId: '456073729010',
   appId: '1:456073729010:web:99f132db8ff22053e8916b',
   measurementId: 'G-JPMK21YCCT',
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

// Initialize Messaging
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/icons/icon-192x192.png'  // Optional: Add your custom notification icon
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
