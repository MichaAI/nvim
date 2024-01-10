#!/usr/bin/env node

var readline = require('readline');
var devnull = require('dev-null');

var rl = readline.createInterface({
  input: process.stdin,
  output: devnull()
});

var jsonString = '';

rl.on('line', function(line) {
  jsonString = jsonString + line;
});

rl.on('close', function() {
    var har = JSON.parse(jsonString);

    console.log(object2keys(har, '').join('\n'));
});

function object2keys(obj, path)
{
    var keys = [];
    for (var key in obj)
    {
        if (obj.hasOwnProperty(key))
        {
            if ('object' == typeof(obj[key]))
            {
                keys = keys.concat(
                    object2keys(obj[key],
                        path +
                        (Array.isArray(obj) ?
                            '[]' :
                            (path ? '.' : '') + key
                        )
                    )
                );
            } 
            else
            {
                keys.push(path + '.' + key);
            }
        }
    }
    return Array.from(new Set(keys));
}
