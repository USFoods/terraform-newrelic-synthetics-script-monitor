/**
 * Feel free to explore, or check out the full documentation
 * https://docs.newrelic.com/docs/synthetics/new-relic-synthetics/scripting-monitors/writing-api-tests
 * for details.
 */

//Import the `assert` module to validate results.
const assert = require('assert');

var execDate = new Date()
var localeDateStr = execDate.toLocaleString('en-US', { timeZone: 'America/Phoenix' });

console.log(localeDateStr);

var execMinute = execDate.getMinutes()

assert.ok(execMinute <= 30, `Current time (${localeDateStr}) is bottom of the hour`);
