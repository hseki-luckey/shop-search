class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    if params[:keyword].present?
       @posts = @posts.get_by_keyword params[:keyword]
    end

    if params[:shop].present?
       @posts = @posts.get_by_name params[:shop]
    end

    if params[:area].present?
      @posts = @posts.search_values_or(:area, params[:area])
    end

    if params[:genre].present?
      @posts = @posts.search_values_or(:genre, params[:genre])
    end

    if params[:rate_l].present?
       @posts = @posts.get_by_rate_l params[:rate_l]
    end

    if params[:rate_u].present?
       @posts = @posts.get_by_rate_u params[:rate_u]
    end

    @posts = @posts.page(params[:page])
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).all
    @comment  = @post.comments.build(user_id: current_user.id) if current_user
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params[:post][:area] = params[:area].join('/')
      params[:post][:genre] = params[:genre].join('/')
      params.require(:post).permit(:shop, :area, :genre, :rate_u, :rate_l, :url)
    end
end
