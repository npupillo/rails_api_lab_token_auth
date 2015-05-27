module Api
  module V1
    class PostsController < ApplicationController
      before_filter :authenticate, only: [:index]
      def index
        @posts = [{title: 'This is Post 1'}, {title: 'This is Post 2'}, {title: 'This is Post 3'}]
        render json: @posts
      end
    end
  end
end
