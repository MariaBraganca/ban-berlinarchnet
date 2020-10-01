class CommentMailer < ApplicationMailer

  def new_comment(comment)
    @comment = comment
    @post = @comment.post

    mail to: @post.user.email, subject: "New comment for #{@post.title}"
  end
end
