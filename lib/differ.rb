class Differ
  def self.find_difference(original_set, subsequent_set)
    added = (subsequent_set - original_set)
    removed = (original_set - subsequent_set)

    { added: added, removed: removed }
  end
end