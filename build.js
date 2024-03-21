import { readFileSync, writeFileSync } from 'node:fs'
import { spawnSync } from 'node:child_process'
import yaml from 'js-yaml'
import ejs from 'ejs'

const data = yaml.load(readFileSync('data.yml', 'utf8'))

data.licensors.sort(byName)

for (const licensor of data.licensors) {
  const { products } = licensor
  if (products) products.sort(byName)
}

function byName (a, b) {
  return a.name.toLowerCase().localeCompare(b.name.toLowerCase())
}

const template = readFileSync('index.template.html', 'utf8')

writeFileSync(
  'index.html',
  ejs.render(template, data)
)

spawnSync('tidy', ['-modify', '-config', 'tidy.config', 'index.html'])
