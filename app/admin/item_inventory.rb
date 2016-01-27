ActiveAdmin.register ItemInventory do
    controller do
      actions :all, :except => [:edit, :destroy, :new]
    end

  index do
    column :item
    column :quantity
    column :station
    default_actions
  end

  end
