class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    @rooms = Room.where(user_id: current_user.id)
    @user = current_user
  end

  def new
    @room = Room.new
    @user = current_user
  end

  def create
    @room = Room.new(room_params)
    @user = current_user
    if @room.save
      flash[:notice_create] = "施設情報を登録しました"
      redirect_to :rooms
    else
      flash[:notice_no_create] = "施設情報の登録に失敗しました"
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @user = current_user
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
    @user = current_user
    if @room.user_id != current_user.id
      redirect_to root_path
    end
  end

  def update
    @room = Room.find(params[:id])
    @user = current_user
    if @room.update(room_params)
      flash[:notice_update] = "施設情報を更新しました"
      redirect_to :rooms
    else
      flash[:notice_no_update] = "施設情報を更新できませんでした"
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice_destroy] = "施設情報を削除しました"
    redirect_to :rooms
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :room_content, :room_price, :room_address, :room_image, :user_id, :room_id)
  end
end
