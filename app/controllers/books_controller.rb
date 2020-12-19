class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all  

    
    
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  respond_to do |format|
    format.html 
    format.js
  end
      

  end

  # POST /books
  # POST /books.json
  def create

    @book = Book.new(book_params)
 
    respond_to do |format|
      if @book.save
        
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
        format.js { flash[:notice] =  'Book was successfully created.'}

      else

        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
        format.js
      end

    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
        format.js {flash[:notice] =  'Book was successfully updated.'}
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
       format.js   {  flash[:notice] =  'Book was successfully deleted .' }
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def import
    Datum.destroy_all
      u = Datum.create data_params
       load u.attachment.path
           respond_to do |format|
        
      format.html {  redirect_to root_path }
      format.json { head :no_content }
       format.js  
    
    end
    
   end

   def info
      u= Datum.first
      #if u != nil
      @books=Book.all
    if u
      change @books,u.attachment.path
      download u.attachment.path
    end
    #return
    
       
   end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name, :phone)
    end

#######################################
      def data_params
      params.require(:'/').permit(:attachment)
   end
 #################################  
   
####################
def load from_file
  line_data={}
  all_data=[]
 File.readlines(from_file).each do |line|
  n, p =line.split(' ')
  line_data[:name] = n
  line_data[:phone] = p
    all_data << line_data
     line_data={}
    end
   
    puts '====================='
    puts line_data
    puts '-------------'
    puts all_data
      unless all_data.empty?
     Book.destroy_all
      end
     all_data.each do |data|
      unless data[:name].blank? or data[:phone].blank?
      Book.create name:data[:name].to_s, phone:data[:phone].to_s
       end
     end 

   all_data
end
####################
def download file
     send_file(file)
end
####################
def change books,filename
  File.open(filename,'w') do |file|
      file.truncate(0)
      books.sort.each do |book|
      file.puts "#{book.name} #{book.phone}"

   end
  end
end
####################

end

