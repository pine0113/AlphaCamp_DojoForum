class RepliesController < ApplicationController
  before_action :set_reply, only: [:update, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    @post.last_reply_time = Time.current
    @post.save!
    redirect_to post_path(@post)
  end

  def update
    if ((@reply.user != current_user) && (current_user.role != "admin"))
      session[:return_to] ||= request.referer
      redirect_to session[:return_to]
      flash[:alert] = "you can not edit this reply"
    else
      if @reply.update(reply_params)
        flash[:notice] = 'reply 已更新'
        redirect_to @reply.post
      else
        flash[:alert] = @reply.errors.full_messages.to_sentence
        render :edit
      end
    end
  end

  def destroy
    if ((@reply.user != current_user) && (current_user.role != "admin"))
      session[:return_to] ||= request.referer
      redirect_to session[:return_to]
      flash[:alert] = "you can not delete this reply"
    else
      @reply.destroy
      session[:return_to] ||= request.referer
      redirect_to session[:return_to]
      flash[:alert] = "reply was deleted"
    end
  end

  private

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end
