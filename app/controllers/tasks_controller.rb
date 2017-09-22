class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  
  def index
      @tasks = current_user.tasks.order("created_at DESC").page(params[:page]).per(3)
  end
  
  def show
  end
  
  def new
    @task = current_user.tasks.build #form_for 用
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "Taskが正常に登録されました"
      redirect_to @task
    else
      flash.now[:danger] = "Taskが登録されませんでした"
      render :new #renderはアクションではなくファイル指定で
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "Taskは正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "Taskは更新されませんでした"
      render :edit
    end
    
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = "Taskは正常に削除されました"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    #ログインユーザが他のリソースへURLからアクセスしようとするとfindではエラーが出る
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  def task_params
    #シンボルはインスタンスを生成した時点で自動的に発生している
    #:taskとすでに生成している（newで）@taskは同じものだが,シンボルアクセスの方が高速
    params.require(:task).permit(:content,:status)
  end
  
end
