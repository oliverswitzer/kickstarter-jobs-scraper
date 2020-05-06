class Changeset < Struct.new(:added, :removed, keyword_init: true)
  def has_changes?
    removed.length > 0 || added.length > 0
  end

  def to_s
    puts "<<<<< Changeset +/- >>>>"
    if added.length > 0
      puts "+++ These elements were added in this changeset +++"
      added.each_with_index do |added_element, index|
        puts "+ element #{index}"
        added_element.each_pair do |attr_name, attr_value|
          puts "    + #{attr_name} #{attr_value}"
        end
      end
    else
      puts "No additional elements added"
    end

    if removed.length > 0
      puts "--- These elements were removed in this changeset ---"
      added.each_with_index do |removed_element, index|
        puts "- element #{index}"
        added_element.each_pair do |attr_name, attr_value|
          puts "    - #{attr_name} #{attr_value}"
        end
      end
    else
      puts "No elements were removed"
    end
  end
end