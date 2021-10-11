class TasksController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @task = @category.tasks.new(task_params)
    @task.user_id = current_user.id
    @task.save
    redirect_to category_path(@category)
  end

  def destroy
    @category = Category.find(params[:category_id])
    @task = @category.tasks.find(params[:id])
    @task.destroy
    redirect_to category_path(@category)
  end

  private
    def task_params
      params.require(:task).permit(:description, :due_date)
    end
end
