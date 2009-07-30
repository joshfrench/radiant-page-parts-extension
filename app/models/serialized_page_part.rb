class SerializedPagePart < PagePart
  serialize :content
  
  def self.display_name
    "Hash Table"
  end
end