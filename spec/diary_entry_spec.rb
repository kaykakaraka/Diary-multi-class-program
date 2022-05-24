require "diary_entry"

RSpec.describe DiaryEntry do
  it "constructs" do
    entry_1 = DiaryEntry.new("Thursday", "I went swimming")
    expect(entry_1.title).to eq "Thursday"
    expect(entry_1.contents).to eq "I went swimming"
  end

  it "formats" do
    entry_1 = DiaryEntry.new("Thursday", "I went swimming")
    expect(entry_1.format).to eq "Thursday: I went swimming"
  end

  it "counts the words in the entry" do
    entry_1 = DiaryEntry.new("Thursday", "I went swimming")
    expect(entry_1.count_words).to eq 3
  end

  it "returns 0 for an empty entry" do
    entry_1 = DiaryEntry.new("Thursday", "")
    expect(entry_1.count_words).to eq 0
  end

  it "returns a mobile number in the entry" do
    entry_1 = DiaryEntry.new("Friday", "07788009009")
    expect(entry_1.mobile_number).to eq ["07788009009"]
  end

  it "returns the mobile number when there is also text in the entry" do  
    entry_1 = DiaryEntry.new("Thursday", "I went swimming with 07891233455")
    expect(entry_1.mobile_number).to eq ["07891233455"]
  end

  it "returns multiple mobile numbers from the same string" do
    entry_1 = DiaryEntry.new("Thursday", "I went with 07790223445 to see 07798223442")
    expect(entry_1.mobile_number).to eq ["07790223445", "07798223442"]
  end

  it "doesn't accept an invalid mobile number" do
    entry_1 = DiaryEntry.new("Thursday", "I went to see 0779822344")
    expect(entry_1.mobile_number).to eq []
  end

  it "doesn't take in duplicates" do
    entry_1 = DiaryEntry.new("Thursday", "I went to see 07798223442. 07798223442 is great")
    expect(entry_1.mobile_number).to eq ["07798223442"]
  end
end
