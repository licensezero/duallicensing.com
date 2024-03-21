import assert from 'node:assert'
import test from 'node:test'
import addFormats from 'ajv-formats'
import Ajv from 'ajv'
import { readFileSync } from 'node:fs'
import yaml from 'js-yaml'

const ajv = new Ajv({ allErrors: true })
addFormats(ajv)
const schema = yaml.load(readFileSync('schema.yml', 'utf8'))
const data = yaml.load(readFileSync('data.yml', 'utf8'))

test('schema', () => {
  assert(ajv.validateSchema(schema), 'valid')
})

test('data', () => {
  const validate = ajv.compile(schema)
  validate(data)
  assert.deepEqual(validate.errors, null, 'conform to schema')
})
