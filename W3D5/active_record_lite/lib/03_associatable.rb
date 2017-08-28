require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = "#{name}_id".to_sym
    @class_name = name.to_s.camelcase
    @primary_key = :id

    options.each do |key,val|
      case key
      when :foreign_key
        @foreign_key = val
      when :class_name
        @class_name = val
      when :primary_key
        @primary_key = val
      end
    end
  end


end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = "#{self_class_name.downcase}_id".to_sym
    @class_name = name.to_s.singularize.camelcase
    @primary_key = :id

    options.each do |key,val|
      case key
      when :foreign_key
        @foreign_key = val
      when :class_name
        @class_name = val
      when :primary_key
        @primary_key = val
      end
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    define_method(name) do
      foreign_key = self.send(options.foreign_key)
      target_class = options.model_class
      target_class.where(id: foreign_key).first
    end
    assoc_options[name] = options
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.to_s, options)
    define_method(name) do
      target_class = options.model_class

      target_class.where(options.foreign_key => self.id)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
