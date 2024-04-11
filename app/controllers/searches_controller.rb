class SearchesController < ApplicationController

    def top
        @user = current_user
        @rooms = Room.search(params[:search])
    end

    def search
        @user = current_user
        @rooms = Room.search(params[:search])
    end

    def keyword_search
        @user = current_user
        @rooms = Room.keyword_search(params[:keyword_search])
    end

end
