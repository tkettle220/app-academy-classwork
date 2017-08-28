require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  attr_accessor :columns

  def self.columns
    return @columns if @columns
    data = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT
        0
    SQL
    @columns = data.first.map{ |el| el.to_sym }
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) do
        attributes[col]
      end
      define_method("#{col}=") do |value|
        attributes[col] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    data = DBConnection.execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    self.parse_all(data)
  end

  def self.parse_all(results)
    results.map do |hash|
      self.new(hash)
    end
  end

  def self.find(id)
    data = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{self.table_name}.id = ?
    SQL
    return nil if data.empty?
    self.new(data.first)
  end

  def initialize(params = {})
    @columns = nil
    cols = self.class.columns
    params.each do |attr_name, val|
      attr_name = attr_name.to_sym
      raise "unknown attribute \'#{attr_name}\'" unless cols.include?(attr_name)
      self.send("#{attr_name}=",val)
    end
  end

  def attributes
    @attributes ||= Hash.new
  end

  def attribute_values
    @attributes.values
  end

  def insert
    col_names = self.class.columns[1..-1].join(", ")
    question_marks = Array.new(self.class.columns.length-1) {"?"}.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
       (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    cols = self.class.columns[1..-1]
    set_line = cols.map {|col| "#{col} = ?"}.join(", ")
    question_marks = Array.new(cols.length-1) {"?"}.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values[1..-1], self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL
  end

  def save
    self.class.find(self.id).nil? ? self.insert : self.update
  end
end
