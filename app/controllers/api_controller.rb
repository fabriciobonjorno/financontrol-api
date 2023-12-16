class ApiController < ApplicationController
  before_action :authorize_access_request!
end
