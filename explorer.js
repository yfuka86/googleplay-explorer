(function() {
  var $, Explorer, explorer, _;

  _ = require('./node_modules/underscore/underscore');

  $ = require('./node_modules/jquery/dist/jquery');

  Explorer = (function() {
    function Explorer() {}

    Explorer.prototype.HIRAGANA = ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'が', 'ぎ', 'ぐ', 'げ', 'ご', 'さ', 'し', 'す', 'せ', 'そ', 'ざ', 'じ', 'ず', 'ぜ', 'ぞ', 'た', 'ち', 'つ', 'て', 'と', 'だ', 'ぢ', 'づ', 'で', 'ど', 'な', 'に', 'ぬ', 'ね', 'の', 'は', 'ひ', 'ふ', 'へ', 'ほ', 'ば', 'び', 'ぶ', 'べ', 'ぼ', 'ぱ', 'ぴ', 'ぷ', 'ぺ', 'ぽ', 'ま', 'み', 'む', 'め', 'も', 'や', 'ゆ', 'よ', 'ら', 'り', 'る', 'れ', 'ろ', 'わ', 'を', 'ん'];

    Explorer.prototype.funcs = [];

    Explorer.prototype.results = [];

    Explorer.prototype.init = function() {
      _.each(this.HIRAGANA, (function(_this) {
        return function(firstChar) {
          _this.funcs.push(function() {
            var key;
            if (firstChar !== 'あ') {
              console.log(_this.results.push(_this.page.evaluate(function() {
                return document.getElementsByTagName('pre')[0].innerHTML;
              })));
            }
            key = encodeURI(firstChar);
            return _this.page.open("https://market.android.com/suggest/SuggRequest?json=1&c=0&query=" + key + "&hl=ja&gl=JP");
          });
          return _.each(_this.HIRAGANA, function(secondChar) {
            return _this.funcs.push(function() {
              var key;
              _this.results.push(_this.page.evaluate(function() {
                return document.getElementsByTagName('pre')[0].innerHTML;
              }));
              key = encodeURI(firstChar + secondChar);
              return _this.page.open("https://market.android.com/suggest/SuggRequest?json=1&c=0&query=" + key + "&hl=ja&gl=JP");
            });
          });
        };
      })(this));
      return this.funcs.push((function(_this) {
        return function() {
          console.log(_this.results.push(_this.page.evaluate(function() {
            return document.getElementsByTagName('pre')[0].innerHTML;
          })));
          return _this.page.open("https://market.android.com");
        };
      })(this));
    };

    Explorer.prototype.execute = function() {
      var recursive;
      this.page = require('webpage').create();
      recursive = (function(_this) {
        return function(i) {
          if (i == null) {
            i = 0;
          }
          if (i < _this.funcs.length) {
            _this.page.onLoadFinished = function() {
              return recursive(i + 1);
            };
            return _this.funcs[i]();
          } else {
            _this.output();
            return phantom.exit();
          }
        };
      })(this);
      return recursive();
    };

    Explorer.prototype.output = function() {
      var result, results;
      results = _.map(this.results, function(result) {
        return $.parseJSON(result);
      });
      results = _.map(results, function(result) {
        return _.map(result, function(obj) {
          return obj.s;
        });
      });
      result = _.reject(results, function(result) {
        return result = '';
      });
      return console.log(results);
    };

    return Explorer;

  })();

  explorer = new Explorer;

  explorer.init();

  explorer.execute();

}).call(this);
