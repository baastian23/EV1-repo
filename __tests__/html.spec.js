
///validar estructura mínima de los HTML.

const fs = require('fs');
const path = require('path');
const { JSDOM } = require('jsdom');

function loadHtml(file) {
  const html = fs.readFileSync(path.join(process.cwd(), file), 'utf-8');
  return new JSDOM(html);
}

describe('Validación HTML básica', () => {
  test('MiCaso.html tiene título y h1', () => {
    const dom = loadHtml('MiCaso.html');
    const { document } = dom.window;
    expect(document.querySelector('title')).toBeTruthy();
    expect(document.querySelector('h1')).toBeTruthy();
  });

  test('index.html contiene el footer global', () => {
    const content = fs.readFileSync('index.html', 'utf-8');
    expect(content).toMatch(/Footer global/i);
  });
});