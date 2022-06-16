class SubtasksController < ApplicationController
    before_action :set_task
    before_action :set_subtask , only:[:show, :edit, :update, :destroy, :complete, :document]
    helper_method :give_status
    def new
        @subtask = Subtask.new
    end

    def create
        @subtask = @task.subtasks.build(subtask_params)
        respond_to do |format|
            if @subtask.save
                format.js
            else
                format.js
            end
        end
    end

    def show
        
    end

    def edit
        
    end

    def update
        respond_to do |format|
            if @subtask.update(subtask_params)
                format.js
            else
                format.js
            end
        end
    end

    def destroy
        @subtask.destroy
    end

    def complete
        @subtask.update_attribute(:complete, params[:complete])
        
    end

    def give_status(subtask)
        if subtask.complete == true
            return "Done"
        else
            return "Pending"
        end
    end

    def document
        if @subtask.update(document_params)
            flash[:notice] = "File uploaded"
        else
            flash[:alert] = "Something went wrong"
        end
        redirect_back(fallback_location: root_path)
    end

    private
    def set_task
        @task = Task.find(params[:task_id])
    end
    def set_subtask
        @subtask = Subtask.find(params[:id])
    end
    def subtask_params
        params.require(:subtask).permit(:title, :description)
    end
    def document_params
        params.require(:subtask).permit(documents: [])
    end

end
