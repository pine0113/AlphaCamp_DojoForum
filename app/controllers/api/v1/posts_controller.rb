class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: :index

  def view
    @post = Post.find_by(id: params[:id])

  end

  def index
    @posts = Post.all
    render json: {
      data: @posts
    }
  end

  def show
    @post = Post.find_by(id: params[:id])
    if !@post
      render json: {
        message: "Can't find the post!",
        status: 400
      }
    else
    render json: {
      data: @post
    }
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: {
        message: "Post created successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      render json: {
        message: "Post updated successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    render json: {
      message: "Post destroy successfully!"
    }
  end


  private
  def post_params
    params.permit(:title, :content,:user_id,
                                :access, :image,:category_ids => [])
  end

end
