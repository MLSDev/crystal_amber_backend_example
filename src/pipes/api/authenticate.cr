class HTTP::Server::Context
  property current_user : User?

  property current_session : Session?
end

class Api::Authenticate < Amber::Pipe::Base
  AUTHORIZATION_TOKEN_KEY              = "token="
  AUTHORIZATION_TOKEN_REGEX            = /^(Token|Bearer)\s+/
  AUTHORIZATION_PAIR_DELIMITERS        = /(?:,|;|\t+)/
  AUTHORIZATION_SPLIT_RAW_PARAMS       = /=(.+)?/
  AUTHORIZATION_GSUB_PARAMS_ARRAY_FROM = /^"|"$/

  def call(context)
    token, options = authorization_token_and_options(context)

    if session = Session.find_by!(token: token)
      context.current_user    = session.user

      context.current_session = session

      call_next(context)
    else
      context.halt! 401
    end
  rescue e
    Amber.logger.error e.message

    authorization = context.request.headers["Authorization"]?

    context.halt! 401 if authorization.is_a?(String) && authorization != ""
  end

  #
  # NOTE: parse header
  #
  def authorization_token_and_options(context)
    _raw_params = context.request.headers["Authorization"].
      sub(AUTHORIZATION_TOKEN_REGEX, "").
      split(/\s*#{ AUTHORIZATION_PAIR_DELIMITERS }\s*/)

    params_array_from = _raw_params.map { |param| param.split AUTHORIZATION_SPLIT_RAW_PARAMS }

    options_array = params_array_from.map do |param|
      param.map { |param_lvl2| param_lvl2.empty? ? nil : param_lvl2 }.compact
    end

    options = {} of String => String?

    options_array.each do |option|
      options[option.first] = option[1]
    end

    [options["token"].to_s.sub(AUTHORIZATION_GSUB_PARAMS_ARRAY_FROM, ""), options.reject("token")]
  end
end
