# frozen_string_literal: true

class SearchController < ApplicationController
  before_action :require_user_log_in!
  def index; end
end
