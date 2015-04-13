class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :html, :json

  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def render_model_error(model)
    render(json: Oj.dump({errors: model.errors}, mode: :compat), status: :bad_request)
  end

  def index
  end
end
