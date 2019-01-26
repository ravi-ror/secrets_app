class SecretsController < ApplicationController
  before_action :set_secret, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    per_page = 10
    params[:page]
    @generate_select_options = %w[1 10 20 50 100]
    @default_select = '10'
    @secrets = Secret.includes(:user).paginate page: params[:page], per_page: per_page
    @start_index = params[:page] ? (params[:page].to_i - 1) * per_page : 0
  end

  def generate
    number = params[:number].to_i
    unless number > 0 && number.is_a?(Numeric)
      respond_to do |format|  
        format.html { redirect_to secrets_path, notice: 'Incorrect number provided' } and return
      end
    end  

    secrets = []
    loop do 
      number.times do |index|
        random_secret = SecureRandom.hex(10)
        secrets << random_secret
      end
      break unless Secret.where(encrypted_secret: secrets).exists?
      secrets = []
    end

    Secret.import secrets.map {|a| {encrypted_secret: a}}

    respond_to do |format|  
      format.html { redirect_to secrets_path, notice: 'Secrets successfully generated.' }
    end
  end

  private
    def set_secret
      @secret = Secret.find(params[:id])
    end

    def secret_params
      params.require(:secret).permit(:encrypted_secret)
    end
end
