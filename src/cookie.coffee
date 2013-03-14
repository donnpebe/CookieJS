@createCookie = (name, value, expires, path, domain) -> 
  cookie = name + "=" + escape value + ";"
  if expires
    if expires instanceof Date
      expires = new Date() if isNaN expires.getTime()
    else
      expires = new Date(new Date().getTime() + parseInt(expires)*1000*60*60*24)
    cookie += "expires=" + expires.toGMTString() + ";"

  cookie += "path=" + path + ";" if path
  cookie += "domain=" + domain + ";" if domain

  document.cookie = cookie

@getCookie = (name) ->
  regexp = new RegExp "(?:^" + name + "|;\\s*"+ name + ")=(.*?)(?:;|$)", "g"
  result = regexp.exec document.cookies
  (result is null) ? null : result[1]

@deleteCookie = (name, path, domain) ->
  createCookie name, "", -1, path, domain if getCookie name
