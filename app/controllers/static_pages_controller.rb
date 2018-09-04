class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:admin]
  before_action :admin?, only: [:admin]

  def about
  end

  def admin
  end

  def contact
  end

  def help
  end

  def home
    if logged_in?
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end
