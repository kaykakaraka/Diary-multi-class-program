class DiaryEntry
  def initialize(title, contents) #title is a string, contents is a string
    @title = title
    @contents = contents
  end

  def title
    @title
  end

  def contents
    @contents
  end

  def format
    "#{@title}: #{@contents}"
  end

  def count_words
    @contents.split(" ").count
  end

  def mobile_number
    numbers = @contents.split(" ").select { |word| word[/[0-9]{11}/] }
    numbers.map! {|numbers| numbers.gsub(/[[:punct:]]/, "")}
    numbers.uniq
  end
end