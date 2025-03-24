'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "0f8c52eb834b6413a7a0cd4619168f6d",
"assets/AssetManifest.bin.json": "c34a67c31ca2230459dbc1464c4b21f9",
"assets/AssetManifest.json": "f949ee85bf4d54d04596bf00a329600d",
"assets/assets/examples/example.json": "1072598e11b5885d4f2874f46e3f25e4",
"assets/assets/icon.png": "2ba486f7037090e67832eeaf5a81d240",
"assets/assets/images/0.S.1.1.png": "6fe84ab9aac9c68dedd24dd2e12296d2",
"assets/assets/images/0.S.1.2.png": "776fbd9a7c474ff3173456278aeec19c",
"assets/assets/images/0.S.1.3.png": "e134a144777595f5dd3208b45849b8bf",
"assets/assets/images/0.S.1.4.png": "889515641b9b736174e2bba2c3bba43d",
"assets/assets/images/0.S.1.5.png": "99a04a80becc3e17e8806e97875653c7",
"assets/assets/images/0.S.1.6.png": "2db75b5f1fba925df73d2a84fc27462b",
"assets/assets/images/bracelet.jpg": "ae0f86fb09f45804cda707d0eb7fefd0",
"assets/assets/images/Castle.png": "8c4e8e0292d0ffeeba7b85682ff3b2fe",
"assets/assets/images/diamond.jpg": "818b73a214ebcce5178d00816c94ed1c",
"assets/assets/images/earings.jpg": "2b1e3ea4c4632fa0156dce5afe6965da",
"assets/assets/images/Image(1).png": "25ae1c945c4f954d68a10709e14d2cba",
"assets/assets/images/Image(2).png": "0b7401781b79ef2d058b5e8caf992c45",
"assets/assets/images/image1.png": "6fe84ab9aac9c68dedd24dd2e12296d2",
"assets/assets/images/Image3.png": "a0a6ca814a404da9bf3da22f4592c598",
"assets/assets/images/Image4.png": "26bb4654d6686ced34fa036f60af3f21",
"assets/assets/images/Image40.png": "456dbb81b9595a6d001d882660f47d14",
"assets/assets/images/Image7.png": "6239f8ab66859d13a263f9401af240f2",
"assets/assets/images/Image8.png": "36b095b0692af5ea23b9fe67aa33c260",
"assets/assets/images/Image9.png": "3949d49fdce53c6d60d9864e0cb238bd",
"assets/assets/images/necklace.jpg": "f4e9e80c73e92ac7c862e9e44d54c60f",
"assets/assets/images/PageView1.jpg": "4c522659bd328e8a1e7b417b001d9c5f",
"assets/assets/images/PageView2.jpg": "8e56c0db1ac69504428b3faee1bb6751",
"assets/assets/images/PageView3.jpg": "8a05e48518f843ce46410ff8b99b4bbb",
"assets/assets/images/PageView4.jpg": "b94ba57d7bbf9e1a066eb5c44af8fd08",
"assets/assets/images/PageView5.jpg": "7ee39f43265f32bc61b86dce4e858c21",
"assets/assets/images/s1.png": "81f989945a875db19675ecc38ffaed64",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "4b18534555cb1bc0041f92b50c23b3ed",
"assets/NOTICES": "955ac984185743219e5c9163027c0616",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2404c51efde066dba77059de790c5f04",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "2265b5b4380faf0b257f9d6d4af15442",
"icons/Icon-192.png": "2ba486f7037090e67832eeaf5a81d240",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "d9a1adf19569d8bcc9ef9c878ea482d0",
"/": "d9a1adf19569d8bcc9ef9c878ea482d0",
"main.dart.js": "f8946eda16fe8faf376bb200212c0131",
"manifest.json": "68182a93434c7a512706b1aadfbcfa03",
"version.json": "6f72ff8e92d9d02a49cd1a8738c3a102"};
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
