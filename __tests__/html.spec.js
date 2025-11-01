///validar estructura mínima de los HTML.

const fs = require('fs');
const { JSDOM } = require('jsdom');

test('MiCaso.html tiene <title> y <h1>', () => {
  const html = fs.readFileSync('MiCaso.html', 'utf-8');
  const dom = new JSDOM(html);
  expect(dom.window.document.querySelector('title')).toBeTruthy();
  expect(dom.window.document.querySelector('h1')).toBeTruthy();
});