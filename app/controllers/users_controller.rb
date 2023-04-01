class UsersController < ApplicationController
  before_action :require_admin, only: [:edit, :update, :destroy]
  # GET /users or /users.json
  # search index
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :asc)
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
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to(profile_path, notice: 'User was successfully created.') }
        format.json { render(:show, status: :created, location: @user) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        if @user.email == current_admin.email
          format.html { redirect_to(profile_path) }
          format.json { render(:show, status: :ok, location: @user) }
        else 
          format.html { redirect_to(user_url(@user), notice: 'User was successfully updated.') }
          format.json { render(:show, status: :ok, location: @user) }
        end
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
  # def destroy
  #   User.find(params[:id]).destroy
  #   respond_to do |format|
  #     if (@user.email == current_admin.email)
  #       format.html { redirect_to(destroy_admin_session_path, notice: 'Account Successfully Deleted') }
  #       format.json { head(:no_content) }
  #     else
  #       format.html { redirect_to(users_path, notice: 'Account Successfully Deleted') }
  #       format.json { head(:no_content) }
  #     end
      
  #   end
  # end

  def destroy
    @user = User.find(params[:id])
    if @current_user.admin?
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:error] = "You must be an admin to perform this action."
      redirect_to root_path
    end
  end
  

  def profile
    @users = User.all
  end

  def help
     @user = User.find(params[:id])
  end

  private

  def require_admin
    unless current_user && current_user.admin?
      flash[:error] = "You must be an admin to perform this action."
      redirect_to root_path
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :uin, :email, :phone_number, :dob, :points, :role_id)
  end
end
