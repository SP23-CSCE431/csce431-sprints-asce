class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  # search index
  def index
    @users = User.all
    if params[:search_by_first_name] && params[:search_by_first_name] != ''
      @users = @users.where('first_name like ?', "%#{params[:search_by_first_name]}%")
    end

    if params[:search_by_last_name] && params[:search_by_last_name] != ''
      @users = @users.where('last_name like ?', "%#{params[:search_by_last_name]}%")
    end

    # if params[:search_by_uin] && params[:search_by_uin] != ""
    #   @users = @users.where("uin like ?", "%#{params[:search_by_uin]}%")
    # end

    # if params[:search_by_email] && params[:search_by_email] != ""
    #   @users = @users.where("email like ?", "%#{params[:search_by_email]}%")
    # end

    # if params[:search_by_phone_number] && params[:search_by_phone_number] != ""
    #   @users = @users.where("phone_number like ?", "%#{params[:search_by_phone_number]}%")
    # end

    # if params[:search_by_dob] && params[:search_by_dob] != ""
    #   @users = @users.where("dob like ?", "%#{params[:search_by_dob]}%")
    # end
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to(user_url(@user), notice: 'User was successfully created.') }
        format.json { render(:show, status: :created, location: @user) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to(user_url(@user), notice: 'User was successfully updated.') }
        format.json { render(:show, status: :ok, location: @user) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url, notice: 'User was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  def profile
    @users = User.all
  end

  def help
     @user = User.find(params[:id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :uin, :email, :phone_number, :dob, :points, :role_id)
  end
end
