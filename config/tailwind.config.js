const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    fontFamily: {
      sans: ['OpenSans', 'sans-serif'],
      tech: ['ShareTechMono', 'monospace']
    },
    extend: {
      colors: {
        'cherry': '#E53E3E',
        'grass': '#90be6d',
        'star': '#e9c46a',
        'ocean': '#3b89aa',
        'plum': '#3b89aa'
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}