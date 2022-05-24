require 'todo_list'

RSpec.describe TodoList do
  it "constructs" do
    todo = TodoList.new
    expect(todo.view_all).to eq []
  end

  it "adds a task to the todo list" do
    todo = TodoList.new
    todo.add("Wash the windows")
    expect(todo.view_all).to eq ["Wash the windows"]
  end
 
  it "adds multiple tasks to the todo list" do
    todo = TodoList.new
    todo.add("Wash the windows")
    todo.add("Take out the bins")
    expect(todo.view_all).to eq ["Wash the windows", "Take out the bins"]
  end

  it "doesn't allow duplicates" do
    todo = TodoList.new
    todo.add("Wash the windows")
    todo.add("Wash the windows")
    expect(todo.view_all).to eq ["Wash the windows"]
  end

end