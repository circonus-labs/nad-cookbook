actions :enable, :disable # one day maybe we'll add :make, whaddaya say
default_action :enable
attribute :name, :kind_of => String, :name_attribute => true
attribute :subdir, :kind_of => String, :required => true
