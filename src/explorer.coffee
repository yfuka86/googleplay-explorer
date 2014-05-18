_ = require('./node_modules/underscore/underscore')
$ = require('./node_modules/jquery/dist/jquery')

class Explorer
  HIRAGANA: [
    'あ','い','う','え','お'#,
    # 'か','き','く','け','こ',
    # 'が','ぎ','ぐ','げ','ご',
    # 'さ','し','す','せ','そ',
    # 'ざ','じ','ず','ぜ','ぞ',
    # 'た','ち','つ','て','と',
    # 'だ','ぢ','づ','で','ど',
    # 'な','に','ぬ','ね','の',
    # 'は','ひ','ふ','へ','ほ',
    # 'ば','び','ぶ','べ','ぼ',
    # 'ま','み','む','め','も',
    # 'や','ゆ','よ',
    # 'ら','り','る','れ','ろ',
    # 'わ','を','ん'
  ]

  funcs: []

  results: []

  init: () ->
    _.each @HIRAGANA, (firstChar) =>
      @funcs.push () =>
        unless firstChar is 'あ'
          console.log @results.push @page.evaluate () ->
            document.getElementsByTagName('pre')[0].innerHTML
        key = encodeURI firstChar
        @page.open "https://market.android.com/suggest/SuggRequest?json=1&c=0&query=#{key}&hl=ja&gl=JP"
      _.each @HIRAGANA, (secondChar) =>
        @funcs.push () =>
          @results.push @page.evaluate () ->
            document.getElementsByTagName('pre')[0].innerHTML
          key = encodeURI(firstChar + secondChar)
          @page.open "https://market.android.com/suggest/SuggRequest?json=1&c=0&query=#{key}&hl=ja&gl=JP"

    # 以下は　んん　のために
    @funcs.push () =>
      console.log @results.push @page.evaluate () ->
        document.getElementsByTagName('pre')[0].innerHTML

  execute: () ->
    @page = require('webpage').create()

    recursive = (i=0) =>
      if i < @funcs.length
        @page.onLoadFinished = ()-> recursive(i+1)
        @funcs[i]()
      else
        () =>
          @output()
          phantom.exit()

    recursive()

  output: () ->
    console.log 'a'
    results = _.map @results (result) ->
      $.parseJSON result
    results = _.map results, (result) ->
      _.map result, (obj) ->
        obj.s
    console.log result

explorer = new Explorer
explorer.init()
explorer.execute()
