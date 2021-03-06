module Authentication
  class Auth0

    def self.authenticate_user!(request)
      options = { algorithm: 'HS256', iss: ENV['AUTH0_DOMAIN'] }
      bearer = request.headers['HTTP_AUTHORIZATION'].try(:slice,7..-1)
      if bearer
        payload, header = JWT.decode(bearer, ENV['AUTH0_CLIENT_SECRET'], true, options)
        puts "WHAT STUFF"
      else
        render json: { status: 401, errors: ['A token must be passed.'] }
      end
    rescue JWT::DecodeError
      render json: { status: 401, errors: ['A token must be passed.'] }
    rescue JWT::ExpiredSignature
      render json: { status: 403, errors: ['The token has expired.'] }
    rescue JWT::InvalidIssuerError
      render json: { status: 403, errors: ['The token does not have a valid issuer.'] }
    rescue JWT::InvalidIatError
      render json: { status: 403, errors: ['The token does not have a valid "issued at" time.'] }
    end

  end
end
