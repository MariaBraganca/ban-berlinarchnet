class CommentsController < ApplicationController

    def create
        @event = Event.find(params[:event_id])
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.date = DateTime.now
        @comment.event = @event
        authorize @comment

        if @comment.save
            redirect_to event_path(@event)
          else
            render :new
          end
    end

    def comment_params
        params.require(:comment).permit(:content)
    end

end
