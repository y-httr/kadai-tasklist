class ToppagesController < ApplicationController
#helper関数はApplicationControllerでincludeしてある
  def index
    #ログイン済みならタスク一覧に飛ばす
    if logged_in?
      redirect_to tasks_url
    end
  end
end
