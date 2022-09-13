local function isEmpty(s)
  return s == nil or s == ''
end

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local function getVal(s)
  return pandoc.utils.stringify(s)
end

function Meta(m)
  local titlepage_table = {
    ["academic"] = function (m)
      m['titlepage-academic'] = true
      return m
    end,
    ["bg-image"] = function (m)
      m['titlepage-bg-image'] = true
      if isEmpty(m['title-bg-image']) then
        m['titlepage-image'] = "corner-bg.png"
      end
      if isEmpty(m['title-bg-location']) then
        m['titlepage-image-location'] = "UL"
      end
      if isEmpty(m['title-bg-size']) then
        m['titlepage-image-size'] = 0.5
      end
      if isEmpty(m['titlepage-geometry']) then
        m['titlepage-geometry'] = pandoc.List({"top=3in", "bottom=1in", "right=1in", "left=1in"})
      end
      return m
    end,
    ["classic-lined"] = function (m)
      m['titlepage-classic-lined'] = true
      return m
    end,
    ["multi-purpose"] = function (m)
      m['titlepage-multi-purpose'] = true
      return m
    end,
    ["thesis-static"] = function (m)
      m['titlepage-thesis-static'] = true
      return m
    end,
    ["vline"] = function (m)
      m['titlepage-vline'] = true
      return m
    end
  }
  
  if not m.titlepage then
    m['titlepage'] = "vline"
  end
  choice = pandoc.utils.stringify(m.titlepage)
  if choice ~= "vline" and choice ~= "bg-image" and choice ~= "multi-purpose" and choice ~= "academic" and choice ~= "thesis"then
    error("titlepage extension error: titlepage can be vline, bg-image, multi-purpose, academic or thesis")
  end
  if isEmpty(choice) then
    titlepage_table["vline"](m)
  else
    titlepage_table[choice](m)
  end

  local coverpage_table = {
    ["titleonly"] = function (m)
      m['coverpage-titleonly'] = true
      return m
    end,
    ["authoronly"] = function (m)
      m['coverpage-authoronly'] = true
      return m
    end,
    ["titleauthor"] = function (m)
      m['coverpage-titleauthor'] = true
      return m
    end,
    ["none"] = function (m)
      m['coverpage-none'] = true
      return m
    end
  }

  if not m.coverpage then
    m['coverpage'] = "none"
  end
  choice = pandoc.utils.stringify(m.coverpage)
  if choice ~= "titleonly" and choice ~= "authoronly" and choice ~= "titleauthor" and choice ~= "none" then
    error("titlepage extension error: coverpage can be titleonly, authoronly, titleauthor or none")
  end
  if isEmpty(choice) then
    coverpage_table["none"](m)
  else
    coverpage_table[choice](m)
  end
  if not m['coverpage-title'] then
    m['coverpage-title'] = m['title']
  end
  if not m['coverpage-author'] then
    m['coverpage-author'] = m['author']
  end
  
  
  if isEmpty(m['coverpage-image']) then
    m['coverpage-image'] = "none"
  end
  choice = pandoc.utils.stringify(m['coverpage-image'])
  print(choice)
  if choice == "none" then
    m['coverpage-image'] = false
  else
    if choice == "great-wave" then
      m['coverpage-image'] = "TheGreatWaveoffKanagawa.jpeg"
      if isEmpty(m['coverpage-color']) then
        m['coverpage-color'] = "F6D5A8"
      end
      if isEmpty(m['coverpage-image-fading']) then
        m['coverpage-image-fading'] = "north"
      end
    end
    if choice == "otter" then
      m['coverpage-image'] = "_extensions/titlepage/images/otter-bar.jpeg"
      if isEmpty(m['coverpage-image-size']) then
        m['coverpage-image-size'] = 1.0
      end
      if isEmpty(m['coverpage-image-opacity']) then
        m['coverpage-image-opacity'] = 0.5
      end
    end
  end
  if m['coverpage-image'] then
    choice = pandoc.utils.stringify(m['coverpage-image'])
    if not file_exists(choice) then
      error("\n\ntitlepage extension error: coverpage-image file cannot be opened. Is the file path and name correct? Using a demo? Demo options are great-wave and otter.\n\n")
    end
  end


  if not isEmpty(m["titlepage-image-location"]) then
    choice = pandoc.utils.stringify(m["titlepage-image-location"])
    if choice ~= "ULCorner" and choice ~= "URCorner" and choice ~= "LLCorner" and choice ~= "LRCorner" and choice ~= "TileSquare" and choice ~= "Center" then
      error("titlepage extension error: titlepage-image-location can be ULCorner, URCorner, LLCorner, LRCorner, TileSquare, or Center")
    end
  end
  
--[[
Set the defaults for the cover title placement
--]]
if m.coverpage then
    if isEmpty(m['coverpage-title-align']) then
        m['coverpage-title-align'] = "left"
    end
    if isEmpty(m['coverpage-title-bottom']) then
        m['coverpage-title-bottom'] = 0.8
    end
    if getVal(m['coverpage-title-align']) == "left" then
      m['coverpage-title-anchor'] = "north west" -- not user controlled
      if isEmpty(m['coverpage-title-left']) then
          m['coverpage-title-left'] = 0.2
      end
      if isEmpty(m['coverpage-title-width']) then
        m['coverpage-title-width'] = 1.0-getVal(m['coverpage-title-left'])-0.1
      end
    end
    if getVal(m['coverpage-title-align']) == "right" then
      m['coverpage-title-anchor'] = "north east" -- not user controlled
      if isEmpty(m['coverpage-title-left']) then
          m['coverpage-title-left'] = 0.8
      end
      if isEmpty(m['coverpage-title-width']) then
        m['coverpage-title-width'] = getVal(m['coverpage-title-left'])-0.1
      end
    end
    if getVal(m['coverpage-title-align']) == "center" then
      m['coverpage-title-anchor'] = "north" -- not user controlled
      if isEmpty(m['coverpage-title-left']) then
          m['coverpage-title-left'] = 0.5
      end
      if isEmpty(m['coverpage-title-width']) then
        m['coverpage-title-width'] = 0.8
      end
    end
    if isEmpty(m['coverpage-title-fontsize']) then
        m['coverpage-title-fontsize'] = 100
    end
    if isEmpty(m['coverpage-title-spacing']) then
       m['coverpage-title-spacing'] = 1.2*getVal(m['coverpage-title-fontsize'])
    end
    if isEmpty(m['coverpage-title-rotate']) then
        m['coverpage-title-rotate'] = 0
    end
    
--[[
Set the defaults for the cover author placement
--]]    
    if m['coverpage-title-fontfamily'] then
       if isEmpty(m['coverpage-author-fontfamily']) then
           m['coverpage-author-fontfamily'] = getVal(m['coverpage-title-fontfamily'])
       end
    end
    if isEmpty(m['coverpage-author-align']) then
        m['coverpage-author-align'] = "left"
    end
    if isEmpty(m['coverpage-author-bottom']) then
        m['coverpage-author-bottom'] = 0.25
    end
    if getVal(m['coverpage-author-align']) == "left" then
      m['coverpage-author-anchor'] = "south west" -- not user controlled
      if isEmpty(m['coverpage-author-left']) then
          m['coverpage-author-left'] = 0.2
      end
      if isEmpty(m['coverpage-author-width']) then
        m['coverpage-author-width'] = 1.0-getVal(m['coverpage-author-left'])-0.1
      end
    end
    if getVal(m['coverpage-author-align']) == "right" then
      m['coverpage-author-anchor'] = "south east" -- not user controlled
      if isEmpty(m['coverpage-author-left']) then
          m['coverpage-author-left'] = 0.8
      end
      if isEmpty(m['coverpage-author-width']) then
        m['coverpage-author-width'] = getVal(m['coverpage-author-left'])-0.1
      end
    end
    if getVal(m['coverpage-author-align']) == "center" then
      m['coverpage-author-anchor'] = "south" -- not user controlled
      if isEmpty(m['coverpage-author-left']) then
          m['coverpage-author-left'] = 0.5
      end
      if isEmpty(m['coverpage-author-width']) then
        m['coverpage-author-width'] = 0.8
      end
    end    
    if isEmpty(m['coverpage-author-fontsize']) then
        m['coverpage-author-fontsize'] = 30
    end
    if isEmpty(m['coverpage-author-spacing']) then
       m['coverpage-author-spacing'] = 1.2*m['coverpage-author-fontsize']
    end
    if isEmpty(m['coverpage-author-rotate']) then
        m['coverpage-author-rotate'] = 0
    end
  end
      


  return m
  
end


