class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :check_permissions, only: [:index , :edit, :destroy]
  before_action :check_officer_permissions, only: [:edit ,:destroy]
  # GET /users or /users.json
  # search index
  # queries the user by the parameter
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :asc)
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  
    # Restrict access to view other user's profiles
    if current_admin&.email != @user.email && (current_admin&.user&.role_id == 3 || current_admin&.user&.role_id.nil?)
      flash[:alert] = "You are not authorized to view this profile."
      redirect_to root_path
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  #If the creationg of a new user is successful, redirect to the user's profile page
  #otherwise re-render new page with error messages
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
  #if the user which is being edited is the active current user, redirect to profile page after successful update
  #otherwise, redirect to their user url
  #if update unsuccessful, redirect back to the edit page with error messages
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
  #if the deleted user is the current active user, redirect back to the signed out dashboard page
  #otherwise, redirect back to the users_path
  def destroy
    User.find(params[:id]).destroy
    respond_to do |format|
      if (@user.email == current_admin.email)
        format.html { redirect_to(destroy_admin_session_path, notice: 'Account Successfully Deleted') }
        format.json { head(:no_content) }
      else
        format.html { redirect_to(users_path, notice: 'Account Successfully Deleted') }
        format.json { head(:no_content) }
      end
      
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

  def check_permissions
    if action_name == 'index'
      if current_admin&.user&.role_id == 3 || current_admin&.user&.role_id.nil?
        flash[:alert] = "You are not authorized to access this action."
        redirect_to root_path
      end
    else
      user_to_edit = User.find_by(id: params[:id])
    
      if (current_admin&.user&.role_id == 3 || current_admin&.user&.role_id.nil?) && current_admin&.email != user_to_edit.email
        flash[:alert] = "You are not authorized to access this action."
        redirect_to root_path
      end
    end
  end

  def check_officer_permissions
    user_to_edit = User.find(params[:id])
    if current_admin.user&.role_id == 2 && current_admin.email != user_to_edit.email
      flash[:alert] = "You are not authorized to edit or delete members."
      redirect_to root_path
    end
  end
end
