class TextPagePart < PagePart
  content :string

  def self.display_name
    "Text (Multiple Line)"
  end

end