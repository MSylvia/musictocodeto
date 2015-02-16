Qajax = require('qajax')

{stdout} = require('../stdout')

module.exports = (context) ->
  {events, errors, formatting, api} = context

  new Object
    helpText: 'userinfo [artist] -- Get vitals on any user on SoundCloud.com'
    run: (cmd, params) ->
      reqParams = 1

      if params.length == reqParams
        artistSlug = params[0]
        request    = api.userinfo(artistSlug)

        request.onValue (data) ->
          if !data.errors
            stdout " "
            stdout "#{formatting.highlight("id:")}          #{data.id}"
            stdout "#{formatting.highlight("username:")}    #{data.username}"
            stdout "#{formatting.highlight("full_name:")}   #{data.full_name}"
            stdout "#{formatting.highlight("city:")}        #{data.city}"
            stdout "#{formatting.highlight("description:")} #{data.description}"
            stdout " "
          else
            stdout "#{formatting.error('error:')} #{data.errors[0].error_message}"
            stdout " "

          events.emit('command:running', false)

        request.onError (data) ->

      else
        stdout errors.requiredParameters(cmd, params, reqParams)
        stdout " "
        events.emit('command:running', false)
