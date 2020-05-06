require_relative './changeset'

class Differ
  def self.find_difference(original_set, subsequent_set)
    added = (subsequent_set - original_set)
    removed = (original_set - subsequent_set)

    Changeset.new(added: added, removed: removed)
  end
end