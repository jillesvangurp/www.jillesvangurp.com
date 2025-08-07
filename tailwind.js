/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    'public/**/*.{html,js,md,css}', // adjust to match your files
  ],
  theme: {
    extend: {
      spacing: {
        430: '430px',
        800: '800px',
      },
    },
  },
  darkMode: 'media', // or 'class'
  plugins: [],
}
