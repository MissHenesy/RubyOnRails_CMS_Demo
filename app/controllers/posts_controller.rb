class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [ :index ]
  before_action :correct_user, only: [ :edit, :show, :update, :destroy ]

  # GET /posts or /posts.json
  def index
    @posts ||= current_user && current_user.posts
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post ||= set_post
    @pull_quotes ||= @post.pull_quotes
    @image_lists ||= @post.image_lists
    # post.image_lists.includes([:image_list_items])
    # @image_list_items ||= @image_lists.includes([:image_list_items])
    @image_list_items = @post.image_list_items
  end

  # GET /posts/new
  def new
    @post ||= current_user.posts.build
    @pull_quotes ||= @post.pull_quotes.build
    @image_lists ||= @post.image_lists.build
    @image_list_items ||= @image_lists.image_list_items.build

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /posts/1/edit
  def edit
    @post ||= set_post
    @pull_quotes = @post.pull_quotes
    @image_lists = @post.image_lists
    #@image_list_items = @post.image_list_items if @image_lists.size > 1
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_with_nested_params)

    respond_to do |format|
      set_publish_date
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      @post ||= set_post
      @pull_quotes ||= @post.pull_quotes
      @image_lists ||= @post.image_lists
      #@image_list_items ||= @post.image_list_items
      set_publish_date
      if @post.update(post_with_nested_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @user = current_user.posts
    redirect_to posts_path, notice: "Hey, You're Not Authorized To View/Edit Other Editor's Post!" if @user.nil?
  end

  private
    def post_with_nested_params
      params
        .require(:post)
        .permit(:id,
                :title,
                :description,
                :body,
                :publish_date,
                :lookup_post_type_id,
                :user_id,
                :save_and_publish,
                pull_quotes_attributes: [:id, :quote, :_destroy],
                image_lists_attributes: [:id, :title, :caption, :image_list_type, :_destroy,
                  image_list_items_attributes: [:id, :title, :caption, :list_image, :list_image_cache, :remove_list_image, :_destroy]]
        )
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_publish_date
      if params[:save_and_publish]
        @post.publish_date = Date.current
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :body, :publish_date, :lookup_post_type_id, :user_id, :save_and_publish)
    end
end
