{{PROBLEM}} Multi-Class Planned Design Recipe

1. Describe the Problem

As a user
So that I can record my experiences
I want to keep a regular diary

As a user
So that I can reflect on my experiences
I want to read my past diary entries

As a user
So that I can reflect on my experiences in my busy day
I want to select diary entries to read based on how much time I have and my reading speed

As a user
So that I can keep track of my tasks
I want to keep a todo list along with my diary

As a user
So that I can keep track of my contacts
I want to see a list of all of the mobile phone numbers in all my diary entries

2. Design the Class System

Consider diagramming out the classes and their relationships. Take care to focus on the details you see as important, not everything. The diagram below uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com

    ┌────────────────────────────────────────────────┐       ┌─────────────────────────────┐
    │                                                │       │                             │
    │ Diary                                          │       │ Diary_Entry                 │
    │                                                │       │                             │
    │ add(entry)                                     │       │ initialize(title, contents) │
    │                                                │       │                             │
    │ read                                           │       │ title                       │
    │                                                │-------│                             │
    │ select to read based on reading time           │       │ contents                    |
    │                                                │       │                             │
    │ view_todo_list                                 │       │  mobile number              │
    │                                                │       │                             │
    │ view mobile numbers                            │       │                             │
    └──────────────────────┬─────────────────────────┘       └─────────────────────────────┘
                           │
                           │
                           │
                           │
                           │
     ┌─────────────────────┴─────────┐
     │                               │
     │ Todo_list                     │
     │                               │
     │ add(task)                     │
     │                               │
     │ view_all                      │
     │                               │
     │                               │
     │                               │
     └───────────────────────────────┘

class Diary
  def initialize
    # ...
  end

  def add_entry(entry) # entry is a Diary_entry object
    # diary entry is added to the diary
    # returns nothing
  end

  def read_all()
    # returns a list of diary entries
  end

  def read_based_on_reading_time(minutes, wpm) # minutes is an integer representing time they have to read
    # returns the longest entry they have time to read   #wpm is an integer representing words they can read per minute
  end
  
  def add_todo(todo_list) # todo_list is an object from the class todo_list
    # adds todo list to the diary
    # returns nothing
    # doesn't allow duplicates
  end

  def view_todo()
    # returns all items on the todo list
  end

  def view_mobile_numbers()
    # returns all mobile numbers in the diary entries
  end
end

class DiaryEntry
  def initialize(title, contents) #title is a string, contents is a string
    #returns nothing
  end

  def title
    #returns the title
  end

  def contents
    # returns the contents
  end

  def count_words
    # returns the word count for the entry
  end

  def mobile_number
    # returns a mobile number from the string if it contains one
    # returns nil if it doesn't
  end
end


class TodoList
  def initialize
    # ...
  end
  
  def add(task) # task is a string
    # returns nothing
  end

  def view_all
    #returns all tasks
  end
end


3. Create Examples as Integration Tests

Create examples of the classes being used together in different situations and combinations that reflect the ways in which the system will be used.


# 1 - Shows all diary entries

diary_1 = Diary.new
entry_1 = DiaryEntry.new("Thursday", "I went swimming")
entry_2 = DiaryEntry.new("Friday", "I ate a nice dinner")
diary_1.add_entry(entry_1)
diary_1.add_entry(entry_2)
diary_1.read_all # => ["Thursday", "I went swimming", "Friday", "I ate a nice dinner"]

# Unit test for diary - constructs
diary_1 = Diary.new
diary_1.read_all # => []

# Unit test for DiaryEntry - constructs
entry_1 = DiaryEntry.new("Thursday", "I went swimming")
entry_1.title # => "Thursday"
entry_1.contents # => "I went swimming"

# 2 - Shows entry to read based on reading time
diary_1 = Diary.new
entry_1 = DiaryEntry.new("Thursday", "I went swimming")
entry_2 = DiaryEntry.new("Friday", "I ate a nice dinner")
diary_1.add_entry(entry_1)
diary_1.add_entry(entry_2)
diary_1.read_based_on_reading_time(3, 2) # => [entry_2]

# 3 - Shows entry to read based on reading time when one is too long 
diary_1 = Diary.new
entry_1 = DiaryEntry.new("Thursday", "I went swimming")
entry_2 = DiaryEntry.new("Friday", "I ate a nice dinner and swam in a lovely lake")
diary_1.add_entry(entry_1)
diary_1.add_entry(entry_2)
diary_1.read_based_on_reading_time(3, 2) # => [entry_1]

# 4 - Adds a todo list to the diary
diary_1 = Diary.new
todo_list = TodoList.new
todo_list.add("Wash the windows")
todo_list.add("Take out the bins")
diary_1.add_todo_list(todo_list)
diary_1.view_todo # => ["Wash the windows", "Take out the bins"]

# Unit test for todo list
todo = TodoList.new
todo.add("Wash the windows")
todo.view_all # => ["Wash the windows"]

todo = TodoList.new
todo.add("Wash the windows")
todo.add("Take out the bins")
todo.view_all # => ["Wash the windows", "Take out the bins"]

# 5 - View a todo list that has been changed after added to the diary 
diary_1 = Diary.new
todo_list = TodoList.new
todo_list.add("Wash the windows")
diary_1.add_todo_list(todo_list)
todo_list.add("Open the windows")
diary_1.view_todo # => ["Wash the windows", "Open the windows"]

# 6 - Returns a list of mobile numbers in the diary entries
diary_1 = Diary.new
entry_1 = DiaryEntry.new("Thursday", "I went swimming with 07891233455")
entry_2 = DiaryEntry.new("Friday", "07788009009")
diary_1.add_entry(entry_1)
diary_1.add_entry(entry_2)
diary_1.view_mobile_numbers # => ["07891233455", "07788009009"]

# 7 - Unit test for DiaryEntry - returns mobile numer
entry_1 = DiaryEntry.new("Friday", "07788009009")
entry_1.mobile_number # => ["07788009009"]

entry_1 = DiaryEntry.new("Thursday", "I went swimming with 07891233455")
entry_1.mobile_number # => "I went swimming with 07891233455"


5. Implement the Behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.