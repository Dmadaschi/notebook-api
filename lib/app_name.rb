class AppName
  def initialize(app, app_name)
    @app = app
    @app_name = app_name
  end

  def call(env)
    status, headers, response = @app.call(env)
    headers.merge!({ 'X-App-Nmae' => @app_name.to_s })
    [status, headers, [response.body]]
  end
end
