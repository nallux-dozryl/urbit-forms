import adapter from '@sveltejs/adapter-static';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	kit: {
    vite: {
      server: {
        proxy: {
          '^/session.js': {
            target: 'http://localhost:8080/',
            changeOrigin: true
          },
          '^/spider/.*': {
            target: 'http://localhost:8080/',
            changeOrigin: true
          },
          '^/~/.*': {
            target: 'http://localhost:8080/',
            changeOrigin: true
          }
        },
        cors: true
      },
      build: {},
      resolve: {
        alias: {
          './runtimeConfig': './runtimeConfig.browser'
        }
      }
    },
    prerender: {
      default: true
    },
    paths: { base: '/apps/forms' },
		adapter: adapter({
      fallback: null
    })

	}
};

export default config;
