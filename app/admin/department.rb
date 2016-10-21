ActiveAdmin.register Department do
  config.batch_actions = true
  config.per_page = 15
  batch_action :destroy, false

  index do
    selectable_column
    column :name
    column :station
    column :created_at
    column :updated_at
    default_actions
  end

end
