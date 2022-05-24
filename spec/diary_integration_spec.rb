require 'diary'
require 'diary_entry'
require 'todo_list'

RSpec.describe "diary project integration" do
  context "when multiple diary entries are added" do
    it "shows all diary entries" do
      diary_1 = Diary.new
      entry_1 = DiaryEntry.new("Thursday", "I went swimming")
      entry_2 = DiaryEntry.new("Friday", "I ate a nice dinner")
      diary_1.add_entry(entry_1)
      diary_1.add_entry(entry_2)
      expect(diary_1.read_all). to eq ["Thursday: I went swimming", "Friday: I ate a nice dinner"]
    end
  end
  
  context "when one diary is added" do
    it "shows one formatted entry" do
      diary_1 = Diary.new
      entry_1 = DiaryEntry.new("Thursday", "I went swimming")
      diary_1.add_entry(entry_1)
      expect(diary_1.read_all). to eq ["Thursday: I went swimming"]
    end
  end

  describe "read_based_on_reading_time method" do
    it "returns the longest entry the reader has time to read" do
      diary_1 = Diary.new
      entry_1 = DiaryEntry.new("Thursday", "I went swimming")
      entry_2 = DiaryEntry.new("Friday", "I ate a nice dinner")
      diary_1.add_entry(entry_1)
      diary_1.add_entry(entry_2)
      expect(diary_1.read_based_on_reading_time(3, 2)).to eq "Friday: I ate a nice dinner"
    end

    it "returns the shorter entry when one is too long" do
      diary_1 = Diary.new
      entry_1 = DiaryEntry.new("Thursday", "I went swimming")
      entry_2 = DiaryEntry.new("Friday", "I ate a nice dinner and swam in a lovely lake")
      diary_1.add_entry(entry_1)
      diary_1.add_entry(entry_2)
      expect(diary_1.read_based_on_reading_time(3, 2)).to eq "Thursday: I went swimming"
    end

    it "returns the entry when there is only one entry and it isn't too long" do
      diary_1 = Diary.new
      entry_1 = DiaryEntry.new("Thursday", "I went swimming")
      diary_1.add_entry(entry_1)
      expect(diary_1.read_based_on_reading_time(70, 4)).to eq "Thursday: I went swimming"
    end

    context "when all entries are too long" do
      it "fails" do
        diary_1 = Diary.new
        entry_1 = DiaryEntry.new("Thursday", "I went swimming")
        entry_2 = DiaryEntry.new("Friday", "I ate a nice dinner and swam in a lovely lake")
        diary_1.add_entry(entry_1)
        diary_1.add_entry(entry_2)
        expect {diary_1.read_based_on_reading_time(1, 2)}.to raise_error "No suitable entries"
      end
    end
  end

  context "a todo list is added to the diary" do
    it "shows all the items on the todo list" do
      diary_1 = Diary.new
      todo_list = TodoList.new
      todo_list.add("Wash the windows")
      todo_list.add("Take out the bins")
      diary_1.add_todo(todo_list)
      expect(diary_1.view_todo).to eq ["Wash the windows", "Take out the bins"]
    end
 
    it "shows an edited version if it changed once added" do
      diary_1 = Diary.new
      todo_list = TodoList.new
      todo_list.add("Wash the windows")
      diary_1.add_todo(todo_list)
      todo_list.add("Open the windows")
      expect(diary_1.view_todo).to eq ["Wash the windows", "Open the windows"]
    end

    context "user tries to add a second to do list" do
      it "fails" do
        diary_1 = Diary.new
        todo_list = TodoList.new
        todo_list.add("Wash the windows")
        diary_1.add_todo(todo_list)
        todo = TodoList.new
        expect {diary_1.add_todo(todo)}.to raise_error "To do list already added"
      end
    end
  end
 
  describe "view mobile numbers" do
    it "shows all mobile numbers from diary entries" do
      diary_1 = Diary.new
      entry_1 = DiaryEntry.new("Thursday", "I went swimming with 07891233455")
      entry_2 = DiaryEntry.new("Friday", "07788009009")
      diary_1.add_entry(entry_1)
      diary_1.add_entry(entry_2)
      expect(diary_1.view_mobile_numbers).to eq ["07891233455", "07788009009"]
    end

    it "shows an empty array when there are no mobile numbers" do
      diary_1 = Diary.new
      entry_1 = DiaryEntry.new("Thursday", "I went swimming")
      entry_2 = DiaryEntry.new("Friday", "I ate a nice dinner")
      diary_1.add_entry(entry_1)
      diary_1.add_entry(entry_2)
      expect(diary_1.view_mobile_numbers).to eq []
    end

    it "doesn't show duplicates" do
      diary_1 = Diary.new
      entry_1 = DiaryEntry.new("Thursday", "I went swimming with 07891233455")
      entry_2 = DiaryEntry.new("Friday", "07891233455")
      diary_1.add_entry(entry_1)
      diary_1.add_entry(entry_2)
      expect(diary_1.view_mobile_numbers).to eq ["07891233455"]
    end
  end
end