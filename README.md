# minispade-rails  [![Build Status](https://secure.travis-ci.org/keithpitt/minispade-rails.png)](http://travis-ci.org/keithpitt/minispade-rails) [![Dependency Status](https://gemnasium.com/keithpitt/minispade-rails.png)](https://gemnasium.com/keithpitt/minispade-rails)

For large JavaScript applications, you need to include and parse alot of JavaScript just to start showing something on the page. minispade-rails allows you to defer the parsing of parts of your application until you need it.

minispade-rails allows you to compile your javascript files into strings that can be required at runtime using [minispade.js](https://github.com/wycats/minispade)

To understand the problem that minispade-rails solves, read [AMD is Not the Answer](http://tomdale.net/2012/01/amd-is-not-the-answer/) by [@tomdale](http://github.com/tomdale) and [Lazy evaluation of CommonJS modules](http://calendar.perfplanet.com/2011/lazy-evaluation-of-commonjs-modules/) by [Tobie Langel](http://tobielangel.com/)

## Getting started

Add the gem to your application Gemfile:

```ruby
gem "minispade-rails"
```

Then replace `require_tree` with `require_spade` and things should _"just work"_, for example:

```javascript
//= require_tree ./your_application
// Becomes...

//= require minispade
//= require_spade ./your_application
```

## What does require_spade do?

Usually, `require_tree` will recursively go through your folder structure, compile the asset, and drop it into the current file. So you get something that looks like this:

```javascript
// path/to/file_1.js
(function() {
   alert('File #1');
}).call(this)
// path/to/file_2.js
(function() {
   alert('File #2');
}).call(this)
// path/to/file_3.js
(function() {
   alert('File #3');
}).call(this)
```

What `require_spade` will do, is it will compile the asset, and drop the contents into a `minispade.register` call, like so:

```javascript
minispade.register("path/to/file_1.js", "alert('File #1')");
minispade.register("path/to/file_2.js", "alert('File #2')");
minispade.register("path/to/file_3.js", "alert('File #3')");
```

Then during your application code, as you need access to "file_1", you simply call `minispade.require` like so:

```javascript
minispade.require("path/to/file_1.js")
```

And it will execute the file. If you've already called `minispade.require` before on the same file, it will do nothing. Note that calling `minispade.require` is a synchronous function call.

## Configuration

The only configuration option that minispade-rails supports at the moment is the ability to switch on/off using a string to defer the parsing of the JavaScript.

Setting `MinispadeRails::Config.deferred` in an initializer to `true` will cause the following output:

```javascript
minispade.register("path/to/file_1.js", "alert('File #1')");
```

Setting it to `false` will give you something like this:

```javascript
minispade.register("path/to/file_1.js", function() { alert('File #1') });
```

Sometimes, evaling code is actually slower than just parsing it. If you have a very small app, but want to future-proof the code, then setting `deferred` to false early on, will give you faster loading times.

See http://blog.sproutcore.com/faster-loading-through-eval/ for more details.

## Contributors / Credits

Thanks to the following:

- [@robmonie](http://twitter.com/robmonie) and [@hassox](http://twitter.com/hassox) for suggesting that this gem could be possible.
- [@wycats](http://github.com/wycats) for writing minispade.js
- [@tomdale](http://github.com/tomdale) for writing his excellent article on AMD

## Note on Patches/Pull Requests

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.
