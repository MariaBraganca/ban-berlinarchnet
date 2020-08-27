class CommentsController < ApplicationController

    def new
        @event = Event.find(params[:event_id])
        @comment = Comment.new
        authorize @comment
      end

    def create_event_comment  
        @event = Event.find(params[:event_id])

        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.date = DateTime.now

        @comment.event = @event
        authorize @comment

        if @comment.save
            redirect_to event_path(@event)
        else
            render 'events/show'
        end
    end

    def create_office_comment
        @office = Office.find(params[:office_id])

        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.date = DateTime.now

        @comment.office = @office
        authorize @comment

        if @comment.save
            redirect_to office_path(@office)
        else
            render 'offices/show'
        end
    end

    def create_post_comment
        @post = Post.find(params[:post_id])

        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.date = DateTime.now

        @comment.post = @post
        authorize @comment

        if @comment.save
            redirect_to post_path(@post)
        else
            render 'posts/show'
        end
    end

    def comment_params
        params.permit(:content)
    end

end
