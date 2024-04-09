class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user_id:current_user.id)
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
    @room = Room.all
    flash[:notice_no_create] = "バリデーションエラーがあります"
    redirect_to controller: :rooms, action: :show, id: @reservation.room_id if @reservation.invalid?
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @user = current_user
    @room = Room.where(id: @reservation.room_id)
    binding.pry
    if @reservation.save
      binding.pry
      flash[:notice_create] = "予約情報を登録しました"
      redirect_to :reservations
    else
      binding.pry
      flash[:notice_no_create] = "予約情報の登録に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @user = current_user
  end

  def edit_confirm
    @reservation = Reservation.new(reservation_params)
    @user = current_user
    @room = Room.all
    flash[:notice_no_create] = "バリデーションエラーがあります"
    redirect_to controller: :rooms, action: :show, id: @reservation.room_id if @reservation.invalid?
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @user = current_user
    @room = Room.where(id: @reservation.room_id)
  end

  def update
    @reservation = Reservation.find(params[:id])
    @user = current_user
    binding.pry
    if @reservation.update(reservation_params)
      binding.pry
      flash[:notice_update] = "予約情報を更新しました"
      redirect_to :reservations
    else
      binding.pry
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
  def reservation_params  # プライベートメソッド 
    params.permit(:checkin, :checkout, :person, :user_id, :room_id)
  end
end
