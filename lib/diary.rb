class Diary
  def initialize
    @entries = []
  end

  def add_entry(entry) # entry is a Diary_entry object
    @entries << entry
  end

  def read_all()
    @entries.map(&:format)
  end

  def read_based_on_reading_time(minutes, wpm)
    words_to_read = minutes * wpm 
    entries = @entries.select { |entry| entry.count_words <= words_to_read }
    fail "No suitable entries" if entries.empty?
    entries.max_by { |entry| entry.count_words }.format
  end
  
  def add_todo(todo_list) # todo_list is an object from the class todo_list
    fail "To do list already added" if !@tasks.nil?
    @tasks = todo_list
  end

  def view_todo()
    fail "No To Do List added" if @tasks.nil?
    @tasks.view_all  
  end

  def view_mobile_numbers()
    @entries.map(&:mobile_number).uniq.flatten
  end
end