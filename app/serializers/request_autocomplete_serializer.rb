class RequestAutocompleteSerializer < ActiveModel::Serializer
  attributes :id
  attributes :label

  private
  def label
    # Because some items have the same name, I wanted to display the options with their IDs tagged on at the end
    object.request_number + " - " + object.title
  end
end