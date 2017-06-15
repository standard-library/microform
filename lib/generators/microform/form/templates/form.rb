class <%= file_name.capitalize %>Form
  attr_reader :<%= file_name %>

  def initialize(<%= file_name %>)
    @<%= file_name %> = <%= file_name %>
  end

  def submit(changeset)
    <%= file_name %>.assign_attributes(changeset)
    return false unless valid?
    <%= file_name %>.save
  end

  def persisted?
    <%= file_name %>.persisted?
  end

  def to_model
    <%= file_name %>
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
