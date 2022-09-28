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

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local function table_concat(t1,t2)
  for _,v in ipairs(t2) do table.insert(t1, v) end
  return t1
end

function Meta(m)
--[[
This function checks that the value the user set is ok and stops with an error message if no.
yamlelement: the yaml metadata. e.g. m["coverpage-theme"]["page-align"]
yamltext: page, how to print the yaml value in the error message. e.g. coverpage-theme: page-align
okvals: a text table of ok styles. e.g. {"right", "center"}
--]]
  local function check_yaml (yamlelement, yamltext, okvals)
    choice = pandoc.utils.stringify(yamlelement)
    if not has_value(okvals, choice) then
      print("\n\ntitlepage extension error: " .. yamltext .. " is set to " .. choice .. ". It can be " .. pandoc.utils.stringify(table.concat(okvals, ", ")) .. ".\n\n")
      return false
    else
      return true
    end

    return true
  end

--[[
This function gets the value of something like coverpage-theme.title-style and sets a value coverpage-theme.title-style.plain (for example). It also
does error checking against okvals. "plain" is always ok and if no value is set then the style is set to plain.
page: titlepage or coverpage
styleement: page, title, subtitle, header, footer, affiliation, etc
okvals: a text table of ok styles. e.g. {"plain", "two-column"}
--]]
  local function set_style (page, styleelement, okvals)
    yamltext = page .. "-theme" .. ": " .. styleelement .. "-style"
    yamlelement = m[page .. "-theme"][styleelement .. "-style"]
    if not isEmpty(yamlelement) then
      ok = check_yaml (yamlelement, yamltext, okvals)
      if ok then
        m[page .. "-style-code"][styleelement] = {}
        m[page .. "-style-code"][styleelement][getVal(yamlelement)] = true
      else
        error()
      end
    else
--      print("\n\ntitlepage extension error: " .. yamltext .. " needs a value. Should have been set in coverpage-theme lua filter.\n\n")
--      error()
        m[page .. "-style-code"][styleelement] = {}
        m[page .. "-style-code"][styleelement]["plain"] = true
    end
  end

--[[
This function assigns the themevals to the meta data
--]]
  local function assign_value (tab)
    for i, value in pairs(tab) do
      if isEmpty(m['coverpage-theme'][i]) then
        m['coverpage-theme'][i] = value
      end
    end

    return m
  end

  local coverpage_table = {
    ["none"] = function (m)
      themevals = {
        ["page-align"] = "left",
        ["title-style"] = "none",
        ["author-style"] = "none",
        ["footer-style"] = "none",
        ["header-style"] = "none",
        ["date-style"] = "none",
        }
      assign_value(themevals)
        
      return m
    end,
    ["title"] = function (m)
      themevals = {
        ["page-align"] = "left",
        ["title-style"] = "plain",
        ["author-style"] = "none",
        ["footer-style"] = "none",
        ["header-style"] = "none",
        ["date-style"] = "none",
        }
      assign_value(themevals)
        
      return m
    end,
    ["author"] = function (m)
      themevals = {
        ["page-align"] = "left",
        ["title-style"] = "none",
        ["author-style"] = "plain",
        ["footer-style"] = "none",
        ["header-style"] = "none",
        ["date-style"] = "none",
        }
      assign_value(themevals)
        
      return m
    end,
    ["titleauthor"] = function (m)
      themevals = {
        ["page-align"] = "left",
        ["title-style"] = "plain",
        ["author-style"] = "plain",
        ["footer-style"] = "none",
        ["header-style"] = "none",
        ["date-style"] = "none",
        }
      assign_value(themevals)
        
      return m
    end,
    ["default"] = function (m)
      themevals = {
        ["page-align"] = "left"
        }
      for key, val in pairs({"title", "author", "footer", "header"}) do
        if not isEmpty(m['coverpage-' .. val]) then
          themevals[val .. "-style"] = "plain"
        else
          themevals[val .. "-style"] = "none"
        end
      end
      assign_value(themevals)
        
      return m
    end,
  }
  
  m['coverpage-file'] = false
  if m.coverpage then
  choice = pandoc.utils.stringify(m.coverpage)
  okvals = {"none", "default", "title", "author", "titleauthor"}
  isatheme = has_value (okvals, choice)
  if not isatheme then
    if not file_exists(choice) then
      error("titlepage extension error: coverpage can be a tex file or one of the themes: " .. pandoc.utils.stringify(table.concat(okvals, ", ")) .. ".")
    else
      m['coverpage-file'] = true
      m['coverpage-filename'] = choice
      m['coverpage'] = "file"
    end
  end
  if not m['coverpage-file'] then
    if isEmpty(m['coverpage-theme']) then
      m['coverpage-theme'] = {}
    end
    coverpage_table[choice](m) -- add the theme defaults
  else
    if not isEmpty(m['coverpage-theme']) then
      print("\n\ntitlepage extension message: since you passed in a static coverpage file, coverpage-theme is ignored.n\n")
    end
  end
  end

-- Only for themes
-- coverpage-theme will exist if using a theme
if not m['coverpage-file'] then
  
-- set the coverpage values unless user passed them in
  for key, val in pairs({"title", "author"}) do
    if isEmpty(m['coverpage-' .. val]) then
      if not isEmpty(m[val]) then
        m['coverpage-' .. val] = getVal(m[val])
      end
    end
  end

--[[
Error checking and setting the style codes
--]]
  -- Style codes
  m["coverpage-style-code"] = {}
  okvals = {"none", "plain"}
  set_style("coverpage", "title", okvals)
  set_style("coverpage", "footer", okvals)
  set_style("coverpage", "header", okvals)
  set_style("coverpage", "author", okvals)

  if isEmpty(m['coverpage-bg-image']) then
    m['coverpage-bg-image'] = "none" -- need for stringify to work
  end
  choice = pandoc.utils.stringify(m['coverpage-bg-image'])
  if choice == "none" then
    m['coverpage-bg-image'] = false
  else
    m['coverpage-theme']['bg-image-anchor'] = "south west" -- fixed
    image_table = {["bottom"] = 0.0, ["left"] = 0.0, ["rotate"] = 0.0, ["opacity"] = 1.0}
    for key, val in pairs(image_table) do
      if isEmpty(m['coverpage-theme']['bg-image-' .. key]) then
        m['coverpage-theme']['bg-image-' .. key] = val
      end
    end
    if isEmpty(m['coverpage-theme']['bg-image-size']) then
      m['coverpage-theme']['bg-image-size'] = pandoc.MetaInlines{
          pandoc.RawInline("latex","\\paperwidth")}
    end
    if not isEmpty(m['coverpage-theme']['bg-image-fading']) then
      okvals = {"top", "bottom", "left", "right", "north", "south", "east", "west", "fadeout" }
      ok = check_yaml (m["coverpage-theme"]["bg-image-fading"], "coverpage-theme: bg-image-fading", okvals)
      if not ok then error("") end
      if getVal(m['coverpage-theme']['bg-image-fading']) == "left" then m['coverpage-theme']['bg-image-fading'] = "west" end
      if getVal(m['coverpage-theme']['bg-image-fading']) == "right" then m['coverpage-theme']['bg-image-fading'] = "east" end
      if getVal(m['coverpage-theme']['bg-image-fading']) == "top" then m['coverpage-theme']['bg-image-fading'] = "north" end
      if getVal(m['coverpage-theme']['bg-image-fading']) == "bottom" then m['coverpage-theme']['bg-image-fading'] = "south" end
    end
  end -- bg-image attributes
  -- Some demos
  if choice == "great-wave" then
    m['coverpage-bg-image'] = "TheGreatWaveoffKanagawa.jpeg"
    if isEmpty(m['coverpage-theme']['page-html-color']) then
      m['coverpage-theme']['page-html-color'] = "F6D5A8"
    end
    if isEmpty(m['coverpage-theme']['bg-image-fading']) then
      m['coverpage-theme']['bg-image-fading'] = "north"
    end
  end
  if choice == "otter" then
    m['coverpage-bg-image'] = "_extensions/titlepage/images/otter-bar.jpeg"
    if isEmpty(m['coverpage-theme']['bg-image-opacity']) then
      m['coverpage-theme']['bg-image-opacity'] = 0.5
    end
  end
  if m['coverpage-bg-image'] then -- not false
    choice = pandoc.utils.stringify(m['coverpage-bg-image'])
    if not file_exists(choice) then
      error("\n\ntitlepage extension error: coverpage-bg-image file " .. choice .. " cannot be opened. Is the file path and name correct? Using a demo? Demo options are great-wave and otter.\n\n")
    end
  end

--[[
Set the fontsize defaults
if page-fontsize was passed in or if fontsize passed in but not spacing
--]]
  if isEmpty(m["coverpage-theme"]["page-fontsize"]) then
    m["coverpage-theme"]["page-fontsize"] = 100
    m['coverpage-theme']["page-spacing"] = 120
  end

  -- if not passed in then it will take page-fontsize and page-spacing
  for key, val in pairs({"title", "author", "footer", "header"}) do
    if not getVal(m["coverpage-theme"][val .. "-style"]) ~= "none" then
      if isEmpty(m["coverpage-theme"][val .. "-fontsize"]) then
        if has_value ({"title", "author"}, val) then
          m["coverpage-theme"][val .. "-fontsize"] = getVal(m["coverpage-theme"]["page-fontsize"])
        else
          m["coverpage-theme"][val .. "-fontsize"] = 0.25*getVal(m["coverpage-theme"]["page-fontsize"])
        end
        if isEmpty(m['coverpage-theme'][val .. "-spacing"]) then
          m['coverpage-theme'][val .. "-spacing"] = 1.2*getVal(m['coverpage-theme'][val .. "-fontsize"])
        end
      end
    end
  end
  -- make sure spacing is set if user passed in fontsize
  for key, val in pairs({"title", "author", "footer", "header"}) do
    if not isEmpty(m['coverpage-theme'][val .. "-fontsize"]) then
      if isEmpty(m['coverpage-theme'][val .. "-spacing"]) then
        m['coverpage-theme'][val .. "-spacing"] = 1.2*getVal(m['coverpage-theme'][val .. "-fontsize"])
      end
    end
  end

--[[
Set author sep character
--]]
  if isEmpty(m['coverpage-theme']["author-sep"]) then
    m['coverpage-theme']["author-sep"] = pandoc.MetaInlines{
          pandoc.RawInline("latex",", ")}
  end
  if getVal(m['coverpage-theme']["author-sep"]) == "newline" then
    m['coverpage-theme']["author-sep"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","\\\\")}
  end

--[[
Set the defaults for the coverpage alignments
default coverpage alignment is left
because coverpage uses tikzpicture, the alignments of the elements must be set
--]]    
  if isEmpty(m['coverpage-theme']["page-align"]) then
    m['coverpage-theme']["page-align"] = "left"
  end
  for key, val in pairs({"page", "title", "author", "footer", "header", "logo", "date"}) do
    if not isEmpty(m["coverpage-theme"][val .. "-align"]) then
      okvals = {"right", "left", "center"}
      if has_value({"title", "author", "footer", "header"}, val) then table.insert(okvals, "spread") end
      ok = check_yaml (m["coverpage-theme"][val .. "-align"], "coverpage-theme: " .. val .. "-align", okvals)
      if not ok then error("") end
    else
      m["coverpage-theme"][val .. "-align"] = getVal(m['coverpage-theme']["page-align"])
    end
  end

--[[
Set left and width alignments, bottom distance and rotation
--]]
  for key, val in pairs({"title", "author", "footer", "header", "date"}) do
    if m['coverpage-theme'][val .. "-style"] ~= "none" then
      if getVal(m['coverpage-theme'][val .. "-align"]) == "left" then
        m['coverpage-theme'][val .. "-anchor"] = "north west" -- not user controlled
        if isEmpty(m['coverpage-theme'][val .. "-left"]) then
          m['coverpage-theme'][val .. '-left'] = 0.2
        end
        if isEmpty(m['coverpage-theme'][val .. '-width']) then
          m['coverpage-theme'][val .. '-width'] = 1.0-getVal(m['coverpage-theme'][val .. '-left'])-0.1
        end
      end -- left
      if getVal(m['coverpage-theme'][val .. '-align']) == "right" then
        m['coverpage-theme'][val .. '-anchor'] = "north east" -- not user controlled
        if isEmpty(m['coverpage-theme'][val .. '-left']) then
          m['coverpage-theme'][val .. '-left'] = 0.8
        end
        if isEmpty(m['coverpage-theme'][val .. '-width']) then
          m['coverpage-theme'][val .. '-width'] = getVal(m['coverpage-theme'][val .. '-left'])-0.1
        end
      end -- right
      if getVal(m['coverpage-theme'][val .. '-align']) == "center" then
        m['coverpage-theme'][val .. '-anchor'] = "north" -- not user controlled
        if isEmpty(m['coverpage-theme'][val .. '-left']) then
          m['coverpage-theme'][val .. '-left'] = 0.5
        end
        if isEmpty(m['coverpage-theme'][val .. '-width']) then
          m['coverpage-theme'][val .. '-width'] = 0.8
        end
      end -- center
      -- Set the bottom distances
      bottom_table = {["title"] = 0.8, ["author"] = 0.25, ["footer"] = 0.1, ["header"] = 0.9, ["date"] = 0.1}
      for bkey, bval in pairs(bottom_table) do
        if isEmpty(m['coverpage-theme'][bkey .. '-bottom']) then
          m['coverpage-theme'][bkey .. '-bottom'] = bval
        end
      end -- bottom distance
      -- set rotation
      if isEmpty(m['coverpage-theme'][val .. '-rotate']) then
        m['coverpage-theme'][val .. '-rotate'] = 0
      end -- rotate
    end -- if style not none
  end -- for loop
  

--[[
Set logo defaults
--]]
  if not isEmpty(m['coverpage-logo']) then
    if isEmpty(m['coverpage-theme']["logo-size"]) then
      m['coverpage-theme']["logo-size"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.2\\paperwidth")}
    end
  end
  
end -- end the theme section

  return m
  
end


