require 'diary'

RSpec.describe Diary do
  it "constructs diary and todo list" do
    diary = Diary.new
    expect(diary.read_all).to eq []
  end

  describe "read based on reading time method" do
    context "there are no diary entries" do
      it "fails" do
        diary = Diary.new
        expect{diary.read_based_on_reading_time(5, 1)}.to raise_error "No suitable entries"
     end
    end
  end

  context "user tries to see todo before it has been added" do
    it "fails" do
      diary = Diary.new
      expect {diary.view_todo}.to raise_error "No To Do List added"
    end
  end

  it "shows an empty array when there are no entries" do
    diary = Diary.new
    expect(diary.view_mobile_numbers).to eq []
  end
end