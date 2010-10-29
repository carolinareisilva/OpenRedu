class Environment < ActiveRecord::Base
  # Representa o ambiente onde o ensino a distância acontece. Pode ser visto
  # como um instituição o provedor de ensino dentro do sistema.

  has_many :courses, :dependent => :destroy
  has_attached_file :avatar, {
    :styles => { :medium => "200x200>", :thumb => "100x100>", :nano => "24x24>" },
    :path => "environments/:attachment/:id/:style/:basename.:extension",
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  accepts_nested_attributes_for :courses
  validates_presence_of :name

  # Sobreescrevendo ActiveRecord.find para adicionar capacidade de buscar por path do Space
  def self.find(*args)
    if args.is_a?(Array) and args.first.is_a?(String) and (args.first.index(/[a-zA-Z\-_]+/) or args.first.to_i.eql?(0) )
      find_by_path(args)
    else
      super
    end
  end

  def to_param
    self.path
  end

end
