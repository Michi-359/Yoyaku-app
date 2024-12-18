class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.where(user_id: current_user.id)
    @rooms = Room.all
    @user = current_user
  end

  def new
    @reservation = Reservation.new
    @user = current_user
    @room = Room.new
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @user = current_user
    @room = Room.where(id: @reservation.room_id)
    if @reservation.invalid?
      flash[:notice_no_create] = "バリデーションエラーがあります"
      redirect_to controller: :rooms, action: :show, id: @reservation.room_id
    else
      @reservation.many_days = (@reservation.checkout - @reservation.checkin)
      @reservation.total_price = @reservation.room.room_price * @reservation.person * @reservation.many_days
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @user = current_user
    @room = Room.where(id: @reservation.room_id)
    if @reservation.save
      flash[:notice_create] = "予約情報を登録しました"
      redirect_to :reservations
    else
      flash[:notice_no_create] = "予約情報の登録に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @user = current_user
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @user = current_user
    @room = Room.where(id: @reservation.room_id)
    if @reservation.user_id != current_user.id
      redirect_to root_path
    end
  end

  def edit_confirm
    @reservation = Reservation.new(reservation_params)
    @user = current_user
    @room = Room.where(id: @reservation.room_id)
    if @reservation.invalid?
      flash[:notice_no_create] = "バリデーションエラーがあります"
      redirect_to controller: :rooms, action: :show, id: @reservation.room_id
    else
      @reservation.many_days = (@reservation.checkout - @reservation.checkin)
      @reservation.total_price = @reservation.room.room_price * @reservation.person * @reservation.many_days
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    @user = current_user
    if @reservation.update(reservation_params)
      flash[:notice_update] = "予約情報を更新しました"
      redirect_to :reservations
    else
      flash[:notice_no_update] = "予約情報を更新できませんでした"
      render "edit"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice_destroy] = "予約情報を削除しました"
    redirect_to :reservations
  end

  private

  def reservation_params
    params.permit(:checkin, :checkout, :person, :room_price, :total_price, :user_id, :room_id)
  end
end
