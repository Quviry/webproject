# frozen_string_literal: true

# Comic controller - unused
class ComicsController < ApplicationController
  def index; end

  def new
    @comics = Comics.new
  end

  def create; end

  def destroy; end
end
