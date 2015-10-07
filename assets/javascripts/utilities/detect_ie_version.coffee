detectIE =

  is_internet_explorer: ->
    window.navigator.appName is "Microsoft Internet Explorer"

  get_internet_explorer_version: ->
    matches = new RegExp(" MSIE ([0-9].[0-9]);").exec(window.navigator.userAgent)
    return parseInt(matches[1].replace(".0", "")) if matches? and matches.length > 1
    true

module.exports = detectIE
