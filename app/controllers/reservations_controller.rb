class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
    @rooms = Room.all
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:notice_create] = "予約情報を登録しました"
      redirect_to :reservations
    else
      flash[:notice_no_create] = "予約情報の登録に失敗しました"
      render "new"
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
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
  def reservation_params  # プライベートメソッド 
    params.require(:reservation).permit(:checkin, :checkout, :person)
  end
end
