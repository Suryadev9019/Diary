class DiaryEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary_entry, only: [:show, :edit, :update, :destroy]

  def index
    @diary_entries = DiaryEntry.all
  end

  def show
    # @diary_entry is set by the before_action :set_diary_entry
  end

   def new
    @diary_entry = DiaryEntry.new
   end

  def create
    @diary_entry = current_user.diary_entries.build(diary_entry_params)
    if @diary_entry.save
      redirect_to @diary_entry,notice: "Diary entry was sucessfully created."
    else
      render :new,status: :unprocessable_entity
    end  
  end

  def edit
  end
  
  def update
    if @diary_entry.update(diary_entry_params)
      redirect_to @diary_entry, notice: "Diary entry was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
 def destroy
    @diary_entry.destroy
    redirect_to diary_entries_path, notice: "Diary entry was successfully deleted."
 end
  private

  def set_diary_entry
    @diary_entry = current_user.diary_entries.find(params[:id])
 end

 def diary_entry_params
  params.require(:diary_entry).permit(:title, :content)
 end
end
