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

function dump(o)
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

function Meta(m)
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
      print("\n\ntitlepage extension error: ", yamltext, " needs a value. Should have been set in titlepage-theme lua filter.\n\n")
      error()
    end
  end

  local titlepage_table = {
    ["academic"] = function (m)
      m['titlepage-academic'] = true
      return m
    end,
    ["bg-image"] = function (m)
      if isEmpty(m['titlepage-theme']["elements"]) then
        m['titlepage-theme']["elements"] = {
          pandoc.MetaInlines{pandoc.RawInline("latex","\\titleblock")}, 
          pandoc.MetaInlines{pandoc.RawInline("latex","\\authorblock")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\affiliationblock")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\vfill")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\logoblock")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\footerblock")}
          }
      end
      if isEmpty(m['titlepage-theme']["page-align"]) then
        m['titlepage-theme']["page-align"] = "left"
      end
      if isEmpty(m['titlepage-theme']["title-style"]) then
        m['titlepage-theme']["title-style"] = "plain"
      end
      if isEmpty(m['titlepage-theme']["title-fontstyle"]) then
        m['titlepage-theme']["title-fontstyle"] = {"large", "bfseries"}
      end
      if isEmpty(m['titlepage-theme']["title-space-after"]) then
        m['titlepage-theme']["title-space-after"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","4\\baselineskip")}
      end
      if isEmpty(m['titlepage-theme']["title-subtitle-space-between"]) then
        m['titlepage-theme']["title-subtitle-space-between"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","1\\baselineskip")}
      end
      if isEmpty(m['titlepage-theme']["subtitle-fontstyle"]) then
        m['titlepage-theme']["subtitle-fontstyle"] = {"large", "textit"}
      end
      if isEmpty(m['titlepage-theme']["author-style"]) then
        m['titlepage-theme']["author-style"] = "superscript-with-and"
      end
      if isEmpty(m['titlepage-theme']["author-fontstyle"]) then
        m['titlepage-theme']["author-fontstyle"] = {"large"}
      end
      if isEmpty(m['titlepage-theme']["author-space-after"]) then
        m['titlepage-theme']["author-space-after"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","2\\baselineskip")}
      end
      if isEmpty(m['titlepage-theme']["affiliation-style"]) then
        m['titlepage-theme']["affiliation-style"] = "numbered-list-with-correspondence"
      end
      if isEmpty(m['titlepage-theme']["affiliation-space-after"]) then
        m['titlepage-theme']["affiliation-space-after"] = "0pt"
      end
      if isEmpty(m['titlepage-theme']["footer-style"]) then
        m['titlepage-theme']["footer-style"] = "plain"
      end
      if isEmpty(m['titlepage-theme']["footer-fontstyle"]) then
        m['titlepage-theme']["footer-fontstyle"] = {"large"}
      end
      if isEmpty(m['titlepage-theme']["footer-space-after"]) then
        m['titlepage-theme']["footer-space-after"] = "0pt"
      end
      if isEmpty(m['titlepage-theme']["logo-size"]) then
        m['titlepage-theme']["logo-size"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.25\\textheight")}
      end
      if isEmpty(m['titlepage-theme']["logo-space-after"]) then
        m['titlepage-theme']["logo-space-after"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.1\\textheight")}
      end
      if isEmpty(m['titlepage-theme']["vrule-width"]) then
        m['titlepage-theme']["vrule-width"] = "1pt"
      end
      if isEmpty(m['titlepage-theme']["bg-image-size"]) then
        m['titlepage-theme']["bg-image-size"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.5\\paperwidth")}
      end
      if isEmpty(m['titlepage-theme']["bg-image-location"]) then
        m['titlepage-theme']["bg-image-location"] = "ULCorner"
      end
      if isEmpty(m['title-bg-image']) then
        m['titlepage-image'] = "corner-bg.png"
      end
      if isEmpty(m['titlepage-geometry']) then
        m['titlepage-geometry'] = pandoc.List({"top=3in", "bottom=1in", "right=1in", "left=1in"})
      end
      return m
    end,
    ["classic-lined"] = function (m)
      if isEmpty(m['titlepage-theme']["elements"]) then
        m['titlepage-theme']["elements"] = {
          pandoc.MetaInlines{pandoc.RawInline("latex","\\titleblock")}, 
          pandoc.MetaInlines{pandoc.RawInline("latex","\\authorblock")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\vfill")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\logoblock")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\footerblock")}
          }
      end
      if isEmpty(m['titlepage-theme']["page-align"]) then
        m['titlepage-theme']["page-align"] = "center"
      end
      if isEmpty(m['titlepage-theme']["title-style"]) then
        m['titlepage-theme']["title-style"] = "doubleline"
      end
      if isEmpty(m['titlepage-theme']["title-fontstyle"]) then
        m['titlepage-theme']["title-fontstyle"] = {"Huge", "uppercase"}
      end
      if isEmpty(m['titlepage-theme']["title-space-after"]) then
        m['titlepage-theme']["title-space-after"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.1\\textheight")}
      end
      if isEmpty(m['titlepage-theme']["title-subtitle-space-between"]) then
        m['titlepage-theme']["title-subtitle-space-between"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","1\\baselineskip")}
      end
      if isEmpty(m['titlepage-theme']["subtitle-fontstyle"]) then
        m['titlepage-theme']["subtitle-fontstyle"] = {"Large"}
      end
      if isEmpty(m['titlepage-theme']["author-style"]) then
        m['titlepage-theme']["author-style"] = "plain-newline"
      end
      if isEmpty(m['titlepage-theme']["author-fontstyle"]) then
        m['titlepage-theme']["author-fontstyle"] = {"Large", "textsc"}
      end
      if isEmpty(m['titlepage-theme']["author-space-after"]) then
        m['titlepage-theme']["author-space-after"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","2\\baselineskip")}
      end
      if isEmpty(m['titlepage-theme']["affiliation-style"]) then
        m['titlepage-theme']["affiliation-style"] = "numbered-list-with-correspondence"
      end
      if isEmpty(m['titlepage-theme']["affiliation-space-after"]) then
        m['titlepage-theme']["affiliation-space-after"] = "0pt"
      end
      if isEmpty(m['titlepage-theme']["footer-style"]) then
        m['titlepage-theme']["footer-style"] = "plain"
      end
      if isEmpty(m['titlepage-theme']["footer-fontstyle"]) then
        m['titlepage-theme']["footer-fontstyle"] = {"large", "textsc"}
      end
      if isEmpty(m['titlepage-theme']["footer-space-after"]) then
        m['titlepage-theme']["footer-space-after"] = "0pt"
      end
      if isEmpty(m['titlepage-theme']["logo-size"]) then
        m['titlepage-theme']["logo-size"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.25\\textheight")}
      end
      if isEmpty(m['titlepage-theme']["logo-space-after"]) then
        m['titlepage-theme']["logo-space-after"] = "1cm"
      end

      return m
    end,
    ["colorbox"] = function (m)
      if isEmpty(m['titlepage-theme']["elements"]) then
        m['titlepage-theme']["elements"] = {
          pandoc.MetaInlines{pandoc.RawInline("latex","\\titleblock")}, 
          pandoc.MetaInlines{pandoc.RawInline("latex","\\vfill")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\authorblock")}
          }
      end
      if isEmpty(m['titlepage-theme']["page-align"]) then
        m['titlepage-theme']["page-align"] = "left"
      end
      if isEmpty(m['titlepage-theme']["title-style"]) then
        m['titlepage-theme']["title-style"] = "colorbox"
      end
      if isEmpty(m['titlepage-theme']["title-fontsize"]) then
        m['titlepage-theme']["title-fontsize"] = 100
      end
      if isEmpty(m['titlepage-theme']["subtitle-fontsize"]) then
        m['titlepage-theme']["subtitle-fontsize"] = 25
      end
      if isEmpty(m['titlepage-theme']["title-space-after"]) then
        m['titlepage-theme']["title-space-after"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","2\\baselineskip")}
      end
      if isEmpty(m['titlepage-theme']["title-subtitle-space-between"]) then
        m['titlepage-theme']["title-subtitle-space-between"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","5\\baselineskip")}
      end
      if isEmpty(m['titlepage-theme']["subtitle-fontstyle"]) then
        m['titlepage-theme']["subtitle-fontstyle"] = {"bfseries"}
      end
      if isEmpty(m['titlepage-theme']["author-style"]) then
        m['titlepage-theme']["author-style"] = "plain-newline"
      end
      if isEmpty(m['titlepage-theme']["author-fontstyle"]) then
        m['titlepage-theme']["author-fontstyle"] = {"Large"}
      end
      if isEmpty(m['titlepage-theme']["author-align"]) then
        m['titlepage-theme']["author-align"] = "right"
      end
      if isEmpty(m['titlepage-theme']["author-space-after"]) then
        m['titlepage-theme']["author-space-after"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","2\\baselineskip")}
      end

      return m
    end,
    ["formal"] = function (m)
      if isEmpty(m['titlepage-theme']["elements"]) then
        m['titlepage-theme']["elements"] = {
          pandoc.MetaInlines{pandoc.RawInline("latex","\\titleblock")}, 
          pandoc.MetaInlines{pandoc.RawInline("latex","\\authorblock")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\vfill")},
          pandoc.MetaInlines{pandoc.RawInline("latex","A report presented at the annual\\\\meeting on 10 August 2025\\\\ \\vspace{0.8cm}")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\logoblock")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\footerblock")}
          }
      end
      if isEmpty(m['titlepage-theme']["page-align"]) then
        m['titlepage-theme']["page-align"] = "center"
      end
      if isEmpty(m['titlepage-theme']["title-style"]) then
        m['titlepage-theme']["title-style"] = "plain"
      end
      if isEmpty(m['titlepage-theme']["title-fontstyle"]) then
        m['titlepage-theme']["title-fontstyle"] = {"Huge", "textbf"}
      end
      if isEmpty(m['titlepage-theme']["title-space-after"]) then
        m['titlepage-theme']["title-space-after"] = "1.5cm"
      end
      if isEmpty(m['titlepage-theme']["title-subtitle-space-between"]) then
        m['titlepage-theme']["title-subtitle-space-between"] = "0.5cm"
      end
      if isEmpty(m['titlepage-theme']["subtitle-fontstyle"]) then
        m['titlepage-theme']["subtitle-fontstyle"] = {"LARGE"}
      end
      if isEmpty(m['titlepage-theme']["author-style"]) then
        m['titlepage-theme']["author-style"] = "plain-newline"
      end
      if isEmpty(m['titlepage-theme']["author-fontstyle"]) then
        m['titlepage-theme']["author-fontstyle"] = {"textbf"}
      end
      if isEmpty(m['titlepage-theme']["footer-style"]) then
        m['titlepage-theme']["footer-style"] = "plain"
      end
      if isEmpty(m['titlepage-theme']["footer-fontstyle"]) then
        m['titlepage-theme']["footer-fontstyle"] = {"Large", "textsc"}
      end
      if isEmpty(m['titlepage-theme']["footer-space-after"]) then
        m['titlepage-theme']["footer-space-after"] = "0pt"
      end
      if isEmpty(m['titlepage-theme']["logo-size"]) then
        m['titlepage-theme']["logo-size"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.4\\textwidth")}
      end
      if isEmpty(m['titlepage-theme']["logo-space-after"]) then
        m['titlepage-theme']["logo-space-after"] = "1cm"
      end

      return m
    end,
    ["vline"] = function (m)
      if isEmpty(m['titlepage-theme']["elements"]) then
        m['titlepage-theme']["elements"] = {
          pandoc.MetaInlines{pandoc.RawInline("latex","\\titleblock")}, 
          pandoc.MetaInlines{pandoc.RawInline("latex","\\authorblock")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\affiliationblock")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\vfill")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\logoblock")},
          pandoc.MetaInlines{pandoc.RawInline("latex","\\footerblock")}
          }
      end
      if isEmpty(m['titlepage-theme']["page-align"]) then
        m['titlepage-theme']["page-align"] = "left"
      end
      if isEmpty(m['titlepage-theme']["title-style"]) then
        m['titlepage-theme']["title-style"] = "plain"
      end
      if isEmpty(m['titlepage-theme']["title-fontstyle"]) then
        m['titlepage-theme']["title-fontstyle"] = {"large", "bfseries"}
      end
      if isEmpty(m['titlepage-theme']["title-space-after"]) then
        m['titlepage-theme']["title-space-after"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","4\\baselineskip")}
      end
      if isEmpty(m['titlepage-theme']["title-subtitle-space-between"]) then
        m['titlepage-theme']["title-subtitle-space-between"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","1\\baselineskip")}
      end
      if isEmpty(m['titlepage-theme']["subtitle-fontstyle"]) then
        m['titlepage-theme']["subtitle-fontstyle"] = {"large", "textit"}
      end
      if isEmpty(m['titlepage-theme']["author-style"]) then
        m['titlepage-theme']["author-style"] = "superscript-with-and"
      end
      if isEmpty(m['titlepage-theme']["author-fontstyle"]) then
        m['titlepage-theme']["author-fontstyle"] = {"large"}
      end
      if isEmpty(m['titlepage-theme']["author-space-after"]) then
        m['titlepage-theme']["author-space-after"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","2\\baselineskip")}
      end
      if isEmpty(m['titlepage-theme']["affiliation-style"]) then
        m['titlepage-theme']["affiliation-style"] = "numbered-list-with-correspondence"
      end
      if isEmpty(m['titlepage-theme']["affiliation-space-after"]) then
        m['titlepage-theme']["affiliation-space-after"] = "0pt"
      end
      if isEmpty(m['titlepage-theme']["footer-style"]) then
        m['titlepage-theme']["footer-style"] = "plain"
      end
      if isEmpty(m['titlepage-theme']["footer-fontstyle"]) then
        m['titlepage-theme']["footer-fontstyle"] = {"large"}
      end
      if isEmpty(m['titlepage-theme']["footer-space-after"]) then
        m['titlepage-theme']["footer-space-after"] = "0pt"
      end
      if isEmpty(m['titlepage-theme']["logo-size"]) then
        m['titlepage-theme']["logo-size"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.25\\textheight")}
      end
      if isEmpty(m['titlepage-theme']["logo-space-after"]) then
        m['titlepage-theme']["logo-space-after"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.1\\textheight")}
      end
      if isEmpty(m['titlepage-theme']["vrule-width"]) then
        m['titlepage-theme']["vrule-width"] = "1pt"
      end

      return m
    end
  }
  
  m['titlepage-file'] = false
  if not m.titlepage then
    m['titlepage'] = "bg-image"
  end
  choice = pandoc.utils.stringify(m.titlepage)
  okvals = {"plain", "vline", "bg-image", "colorbox", "academic", "formal"}
  isatheme = has_value (okvals, choice)
  if not isatheme then
    if not file_exists(choice) then
      error("titlepage extension error: titlepage can be a tex file or one of the themes: " .. pandoc.utils.stringify(table.concat(okvals, ", ")) .. ".")
    else
      m['titlepage-file'] = true
      m['titlepage-filename'] = choice
      m['titlepage'] = "file"
    end
  end
  if not m['titlepage-file'] then
    if isEmpty(m['titlepage-theme']) then
      m['titlepage-theme'] = {}
    end
    titlepage_table[choice](m) -- add the theme defaults
  else
    if not isEmpty(m['titlepage-theme']) then
      print("\n\ntitlepage extension message: since you passed in a static titlepage file, titlepage-theme is ignored.n\n")
    end
  end

-- Only for themes
-- titlepage-theme will exist if using a theme
if not m['titlepage-file'] then
--[[
Error checking the style codes
--]]
  -- Style codes
  m["titlepage-style-code"] = {}
  okvals = {"none", "plain", "colorbox", "doubleline"}
  set_style("titlepage", "title", okvals)
  okvals = {"none", "plain", "plain-with-and", "plain-newline", "plain-superscript", "superscript", "superscript-with-and", "two-column"}
  set_style("titlepage", "author", okvals)
  okvals = {"none", "numbered-list", "numbered-list-with-correspondence"}
  set_style("titlepage", "affiliation", okvals)
  set_style("titlepage", "footer", {"none", "plain"})

--[[
Set the fontsize defaults
if page-fontsize was passed in or if fontsize passed in but not spacing
--]]
  for key, val in pairs({"title", "author", "affiliation", "footer", "header", "footer"}) do
    if isEmpty(m["titlepage-theme"][val .. "-fontsize"]) then
      if not isEmpty(m["titlepage-theme"]["page-fontsize"]) then
        m["titlepage-theme"][val .. "-fontsize"] = getVal(m["titlepage-theme"]["page-fontsize"])
      end
    end
  end
  if isEmpty(m['titlepage-theme']["subtitle-fontsize"]) then
    if not isEmpty(m['titlepage-theme']["title-fontsize"]) then
      m['titlepage-theme']["subtitle-fontsize"] = getVal(m['titlepage-theme']["title-fontsize"])
    end
  end
  for key, val in pairs({"page", "title", "subtitle", "author", "affiliation", "footer", "header", "footer"}) do
    if not isEmpty(m['titlepage-theme'][val .. "-fontsize"]) then
      if isEmpty(m['titlepage-theme'][val .. "-spacing"]) then
        m['titlepage-theme'][val .. "-spacing"] = 1.2*getVal(m['titlepage-theme'][val .. "-fontsize"])
      end
    end
  end

--[[
Set vrule defaults
--]]
  if not isEmpty(m['titlepage-theme']["vrule-width"]) then
    if isEmpty(m['titlepage-theme']["vrule-color"]) then
      m['titlepage-theme']["vrule-color"] = "black"
    end
    if isEmpty(m['titlepage-theme']["vrule-space"]) then
      m['titlepage-theme']["vrule-space"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.05\\textheight")}
    end
    if isEmpty(m['titlepage-theme']["vrule-align"]) then
      m['titlepage-theme']["vrule-align"] = "left"
    end
  end
  if not isEmpty(m["titlepage-theme"]["vrule-align"]) then
    okvals = {"left", "right", "leftright"}
    check_yaml (m["titlepage-theme"]["vrule-align"], "titlepage-theme: vrule-align", okvals)
  end

--[[
Set the defaults for the titlepage fonts
Don't set a font unless the user did
--]]    
  if isEmpty(m['titlepage-theme']["title-fontfamily"]) then 
    if not isEmpty(m['titlepage-theme']["page-fontfamily"]) then
      m['titlepage-theme']["title-fontfamily"] = getVal(m['titlepage-theme']["page-fontfamily"])
    end
  end
  if isEmpty(m['titlepage-theme']["author-fontfamily"]) then 
    if not isEmpty(m['titlepage-theme']["page-fontfamily"]) then
      m['titlepage-theme']["author-fontfamily"] = getVal(m['titlepage-theme']["page-fontfamily"])
    end
  end
  if isEmpty(m['titlepage-theme']["affiliation-fontfamily"]) then 
    if not isEmpty(m['titlepage-theme']["page-fontfamily"]) then
      m['titlepage-theme']["affiliation-fontfamily"] = getVal(m['titlepage-theme']["page-fontfamily"])
    end
  end
  if isEmpty(m['titlepage-theme']["header-fontfamily"]) then 
    if not isEmpty(m['titlepage-theme']["page-fontfamily"]) then
      m['titlepage-theme']["header-fontfamily"] = getVal(m['titlepage-theme']["page-fontfamily"])
    end
  end
  if isEmpty(m['titlepage-theme']["footer-fontfamily"]) then 
    if not isEmpty(m['titlepage-theme']["page-fontfamily"]) then
      m['titlepage-theme']["footer-fontfamily"] = getVal(m['titlepage-theme']["page-fontfamily"])
    end
  end

--[[
Set the defaults for the titlepage alignments
default titlepage alignment is left
--]]    
  if isEmpty(m['titlepage-theme']["page-align"]) then
    m['titlepage-theme']["page-align"] = "left"
  end
  for key, val in pairs({"page", "title", "author", "affiliation", "footer", "header", "footer", "logo"}) do
    if not isEmpty(m["titlepage-theme"][val .. "-align"]) then
      okvals = {"right", "left", "center"}
      if has_value({"title", "author", "footer", "header"}, val) then table.insert(okvals, "spread") end
      ok = check_yaml (m["titlepage-theme"][val .. "-align"], "titlepage-theme: " .. val .. "-align", okvals)
      if not ok then error("") end
    end
  end
  
--[[
Set bg-image defaults
--]]
  if not isEmpty(m['titlepage-bg-image']) then
    if isEmpty(m['titlepage-theme']["bg-image-size"]) then
      m['titlepage-theme']["bg-image-size"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","\\paperwidth")}
    end
    if not isEmpty(m["titlepage-theme"]["bg-image-location"]) then
      okvals = {"URCorner", "LLCorner", "LRCorner", "TileSquare", "Center"}
      check_yaml (m["titlepage-theme"]["bg-image-location"], "titlepage-theme: bg-image-location", okvals)
    end  
  end

--[[
Set logo defaults
--]]
  if not isEmpty(m['titlepage-logo']) then
    if isEmpty(m['titlepage-theme']["logo-size"]) then
      m['titlepage-theme']["logo-size"] = pandoc.MetaInlines{
          pandoc.RawInline("latex","0.2\\paperwidth")}
    end
  end
  
end -- end the theme section

  return m
  
end


