class ContactsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    if params[:label_id]
      @label = Label.find(params[:label_id])
      @contacts = @label.contacts
    else
      @contacts = Contact.all
    end
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      flash[:notice] = "Contact was successfully created"
      redirect_to contacts_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      flash[:notice] = "Contact was successfully updated"
      redirect_to contact_url(@contact)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    flash[:notice] = "Contact was successfully deleted"
    redirect_to contacts_url
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :note, label_ids: [])
  end

  def not_found
    render file: "public/404.html", status: :not_found
  end
end
