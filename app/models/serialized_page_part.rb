class SerializedPagePart < PagePart
  serialize :content
  
  def self.display_name
    "Serialized Data"
  end

end