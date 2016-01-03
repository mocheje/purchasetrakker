class ItemAutocompleteSerializer < ActiveModel::Serializer
  attributes :id
  attributes :label

  private
  def label
    # Because some items have the same name, I wanted to display the options with their IDs tagged on at the end
    object.name + " - " + object.id.to_s
  end
end