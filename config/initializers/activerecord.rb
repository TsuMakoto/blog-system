module ActiveRecord
  class Base
    # モデル/カラムのI18n表示名
    # @param  [Symbol] カラム名 : nilならモデル表示名を返す
    # @return [String] モデル/カラムのI18n表示名
    def self.t(column = nil)
      return self.model_name.human if column.nil?

      self.human_attribute_name(column)
    end
  end
end
