class LabelsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)

    if @label.save
      flash.now[:notice] = "Label was successfully created"
      # Rails.cache.delete("labels")
      # @labels = Rails.cache.fetch("labels") { Label.order(:name) }
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])

    if @label.update(label_params)
      flash.now[:notice] = "Label was successfully updated"
      # Rails.cache.delete("labels")
      # @labels = Rails.cache.fetch("labels") { Label.order(:name) }
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    flash.now[:notice] = "Label was successfully deleted"
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  def not_found
    render file: "public/404.html", status: :not_found
  end
end
