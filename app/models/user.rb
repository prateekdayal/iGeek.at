class User < ActiveRecord::Base
  include Gravtastic
  gravtastic :size => 48, :filetype => :gif#, :default => 'http://igeek.at/images/geek_profile.png'
  
  validates_format_of :geek_id, :with => /^[a-zA-Z0-9_.]*$/, :on => :create
  validates_presence_of :provider, :uid, :name, :email, :geek_id
  validates_uniqueness_of :email, :geek_id
  validates_uniqueness_of :uid, :scope => :provider
  validates_exclusion_of  :geek_id, :in=>%w(blog music genre music-community song photos group bands video press contests community forums about business corporate browse member radio account online-radio record record-online mp3 download artist artists album albums event events category store classified classifieds buy discuss discussion discussions comment comments recent latest buzzing review reviews home my_home city country charts replies subscribe stats karaoke upload tour audio friend screenshots facebook twitter sitemap support contact pro reorder block settings abingo discussions page user product contact auth signout geek) 

  has_many  :product_users, :dependent => :destroy
  has_many  :products, :through => :product_users

  def self.random
    if (c = count) != 0
      find(:first, :offset =>rand(c))
    end
  end
  
end
