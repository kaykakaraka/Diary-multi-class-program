class TodoList
  def initialize
    @tasks = []
  end
  
  def add(task) # task is a string
    @tasks << task if !@tasks.include? task
  end

  def view_all
    @tasks
  end
end