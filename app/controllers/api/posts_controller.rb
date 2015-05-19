module Api
  class PostsController < ApiController
    def create
      @post = Post.new(post_params)

      if @post.save
        render json: @post
      else
        render json: @post.errors.full_messages, status: :unprocessable_entity
      end
    end

    def index
      @posts = Post.all
      render :index
    end

    def show
      @post = Post.find(params[:id])
      render :show
    end

    private

    def post_params
      # has title?
      params.require(:post).permit(:title, :feed_id, :ig_url)
    end
  end
end
