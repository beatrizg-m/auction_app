# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @batches = Batch.all
  end
end
