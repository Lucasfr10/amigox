class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :raffle]

  def raffle
    @group.raffle()
    redirect_to group_path(@group)
  end

  def accept_invite
    group = Group.find(params[:group_id])
    group.accept_invite(params[:user_id])
    redirect_to group_path(group)
  end

  def recuse_invite
    group = Group.find(params[:group_id])
    group.recuse_invite(params[:user_id])
    redirect_to group_path(group)
  end

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
    @group.user_id = session[:logged]["id"]
  end

  # GET /groups/1/edit
  def edit
    @select_user = @group.users
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    @group.user_id = session[:logged]["id"]

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      group_params = params.require(:group).permit(:name, user_ids: [])
      group_params["user_ids"] = group_params["user_ids"][0].split(",")
      group_params
    end
end
