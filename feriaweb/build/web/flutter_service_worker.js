'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a7f0e5dcd4271e260cd47e67efefeb0d",
"assets/AssetManifest.bin.json": "3c7a35ddefba4bcd025ad3d76de97cd7",
"assets/AssetManifest.json": "c6dbcef825a3ab4d5a12930f5c2ecf30",
"assets/assets/2.png": "48605372d3ecb34664f1cd01e8ee208b",
"assets/assets/Fondo.webp": "0918ce8c87caa5770accfd70949e35f1",
"assets/assets/FondoLogin.png": "a2a7f8d53781066a2bf7b3d1809c6159",
"assets/assets/FondoLogin2.png": "a61f712cd61a2d81628e7c6d237f1d7b",
"assets/assets/icons/Calendar.png": "c31e7c123d280671086e5993709d46fd",
"assets/assets/icons/Campana.png": "f3197613f1cb5e5e90e1ce8dad36a643",
"assets/assets/icons/Cerrar%2520Sesion.png": "dedd35681b56c47441099dbc72926b1e",
"assets/assets/icons/Check.png": "b37cfc5f21e4f961708b3e0abf57f314",
"assets/assets/icons/Desplazar%2520SideBar.png": "82ee097b8162afe1b664b8190a1558b0",
"assets/assets/icons/Document.png": "b6b46c1e7fbd3c81b240f3691293affb",
"assets/assets/icons/dollar-sign.png": "1abfda4e93786deab6f13fb8328bd5c7",
"assets/assets/icons/Engranaje.png": "dbf38d3baf513f495b4a33797319fb33",
"assets/assets/icons/EPS.png": "be0b6bd516f1f1881e2c00ccfd443c41",
"assets/assets/icons/Filtro.png": "e8fb30fbd7d294133100d4e9335e5c6d",
"assets/assets/icons/Giropay.png": "ffa82472e8c9217c8bd3b9355659db42",
"assets/assets/icons/google.png": "70e3a6d2999ce23f065b000414fe7b20",
"assets/assets/icons/google_icon1.png": "1d94cfe2ce6b5f05f74684ac04af8467",
"assets/assets/icons/Mastercard.png": "390ea8389e48f503b03be8fabf6b33f8",
"assets/assets/icons/mastercard2.png": "82139ffd73d8025a5b873198e8639f45",
"assets/assets/icons/Opciones%2520Arch%2520upload.png": "114275b634b033d62b720da0248940ff",
"assets/assets/icons/PDF.png": "9b0fadb7fd5857724c86a43a5b5655d4",
"assets/assets/icons/Regresar.png": "84f0140b26f201100df28f5d597db2f9",
"assets/assets/icons/Retry.png": "417a09553b0e1cf129230e27a6aac0cd",
"assets/assets/icons/Seleccionar%2520.png": "6e967fad48dadc331bbf330aeb5dfe9c",
"assets/assets/icons/Seleccionar%2520Archivo.png": "42434f3580c01d42340e73fac604eb94",
"assets/assets/icons/Tarjeta.png": "495054797236097c0f7057fd695808c9",
"assets/assets/icons/Upload.png": "3c2f0ce7c6c95e91cc7d707a6db4ec31",
"assets/assets/icons/VISA.png": "6d5f9e38bc7c2dfff400cf8614e61a23",
"assets/assets/icons/Volver.png": "55c1389708d01b6f142f0e98df8837b5",
"assets/assets/logiquick-logo.png": "4c408b6ea807f0321c24ce4ca9d3723a",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "b20e5e8224f43ad621461077ee2e41b1",
"assets/NOTICES": "ae3cfe069a7756e85212619b7ce46e65",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "f2064ea239233d6cf9f080824fae3c8a",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "b86dc88ac10960d0417c7ff40dd645d0",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "8bb6c4bcb841f02c2920ba182f1c7215",
"/": "8bb6c4bcb841f02c2920ba182f1c7215",
"main.dart.js": "0cc4c09494f371a2467fc9b8cf5a05c7",
"manifest.json": "082b33665e766b266798592089d725cf",
"version.json": "a12bca27b39d628960dd3bd9b447a178"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
