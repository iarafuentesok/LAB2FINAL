const API_BASE_URL = 'https://lab2final-m22q.onrender.com';

const originalFetch = window.fetch;
window.fetch = function (url, options) {
  if (typeof url === 'string' && url.startsWith('/')) {
    url = API_BASE_URL + url;
  }
  return originalFetch(url, options);
};

window.connectSocket = function () {
  return io(API_BASE_URL);
};
