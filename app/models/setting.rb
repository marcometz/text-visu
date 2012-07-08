class Setting < ActiveRecord::Base
  attr_accessible :name, :value

  def self.for_key(search, default = "")
    set = Setting.find_by_name(search)
    unless set
      set = Setting.create(:name => search, :value => default)
    end
    set.value
  end
end
