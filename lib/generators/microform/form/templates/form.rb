class <%= file_name.capitalize %>Form
  attr_reader :<%= file_name %>

  delegate :persisted?, to: :<%= file_name %>
  delegate :to_model, to: :<%= file_name %>
  delegate :to_param, to: :<%= file_name %>

  def initialize(<%= file_name %>)
    @<%= file_name %> = <%= file_name %>
  end

  def submit(changeset)
    <%= file_name %>.assign_attributes(changeset)
    return false unless valid?
    <%= file_name %>.save
  end

  def method_missing(method, *args)
    if <%= file_name %>.respond_to?(method, *args)
      <%= file_name %>.send(method, *args)
    else
      super
    end
  end

  def respond_to?(method, *args)
    <%= file_name %>.respond_to?(method, *args) || super
  end
end
