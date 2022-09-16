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
    m['titlepage'] = "vline"
  end
  choice = pandoc.utils.stringify(m.titlepage)
  if choice ~= "plain" and choice ~= "vline" and choice ~= "bg-image" and choice ~= "colorbox" and choice ~= "academic" and choice ~= "formal" and choice ~= "classic-lined" then
    if not file_exists(choice) then
      error("titlepage extension error: titlepage can be a tex file or one of the themes: plain, vline, bg-image, colorbox, academic or formal")
    else
      m['titlepage-file'] = true
      m['titlepage-filename'] = choice
      m['titlepage'] = "file"
    end
  end
  if not m['titlepage-file'] then
    if isEmpty(m['titlepage-theme']) then
      m['titlepage-theme'] = {key1 = 'dummy'}
    end
    titlepage_table[choice](m)
  else
    if not isEmpty(m['titlepage-theme']) then
      print("\n\ntitlepage extension message: since you passed in a titlepage file, titlepage-theme is ignored.n\n")
    end
  end

-- Only for themes
-- titlepage-theme will exist if using a theme
if not m['titlepage-file'] then
--[[
Error checking the inputs
--]]
  if not isEmpty(m["titlepage-theme"]["title-style"]) then
    choice = pandoc.utils.stringify(m["titlepage-theme"]["title-style"])
    if choice ~= "none" and choice ~= "plain" and choice ~= "colorbox" and choice ~= "doubleline" then
      error("\n\ntitlepage extension error: titlepage-theme.title-style can be none, plain, doubleline, and colorbox\n\n")
    else
      m["titlepage-title-style-code"] = {}
      m["titlepage-title-style-code"][getVal(m["titlepage-theme"]["title-style"])] = true
    end
  end
  if not isEmpty(m["titlepage-theme"]["bg-image-location"]) then
    choice = pandoc.utils.stringify(m["titlepage-theme"]["bg-image-location"])
    if choice ~= "ULCorner" and choice ~= "URCorner" and choice ~= "LLCorner" and choice ~= "LRCorner" and choice ~= "TileSquare" and choice ~= "Center" then
      error("\n\ntitlepage extension error: titlepage-theme.bg-image-location can be ULCorner, URCorner, LLCorner, LRCorner, TileSquare, or Center\n\n")
    end
  end
  if not isEmpty(m["titlepage-theme"]["page-align"]) then
    choice = pandoc.utils.stringify(m["titlepage-theme"]["page-align"])
    if choice ~= "right" and choice ~= "left" and choice ~= "center" then
      error("\n\ntitlepage extension error: titlepage-theme.page-align can be right, left, center\n\n")
    end
  end
  if not isEmpty(m["titlepage-theme"]["title-align"]) then
    choice = pandoc.utils.stringify(m["titlepage-theme"]["title-align"])
    if choice ~= "right" and choice ~= "left" and choice ~= "center" and choice ~= "spread" then
      error("\n\ntitlepage extension error: titlepage-theme.title-align can be right, left, center, spread\n\n")
    end
  end
  if not isEmpty(m["titlepage-theme"]["author-align"]) then
    choice = pandoc.utils.stringify(m["titlepage-theme"]["author-align"])
    if choice ~= "right" and choice ~= "left" and choice ~= "center" and choice ~= "spread" then
      error("\n\ntitlepage extension error: titlepage-theme.author-align can be right, left, center, spread\n\n")
    end
  end

--[[
Set the fontsize defaults
--]]
if not isEmpty(m['titlepage-theme']["title-fontsize"]) then
  if isEmpty(m['titlepage-theme']["title-spacing"]) then
    m['titlepage-theme']["title-spacing"] = 1.2*getVal(m['titlepage-theme']["title-fontsize"])
  end
end
if not isEmpty(m['titlepage-theme']["subtitle-fontsize"]) then
  if isEmpty(m['titlepage-theme']["subtitle-spacing"]) then
    m['titlepage-theme']["subtitle-spacing"] = 1.2*getVal(m['titlepage-theme']["subtitle-fontsize"])
  end
end
if not isEmpty(m['titlepage-theme']["author-fontsize"]) then
  if isEmpty(m['titlepage-theme']["author-spacing"]) then
    m['titlepage-theme']["author-spacing"] = 1.2*getVal(m['titlepage-theme']["author-fontsize"])
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

--[[
Set the defaults for the titlepage alignments
--]]    
  if isEmpty(m['titlepage-theme']["page-align"]) then
    m['titlepage-theme']["page-align"] = "left"
  end
  if isEmpty(m['titlepage-theme']["title-align"]) then 
      m['titlepage-theme']["title-align"] = getVal(m['titlepage-theme']["page-align"])
  end
  if isEmpty(m['titlepage-theme']["author-align"]) then 
      m['titlepage-theme']["author-align"] = getVal(m['titlepage-theme']["page-align"])
  end
  if isEmpty(m['titlepage-theme']["affiliation-align"]) then 
      m['titlepage-theme']["affiliation-align"] = getVal(m['titlepage-theme']["page-align"])
  end
  if isEmpty(m['titlepage-theme']["header-align"]) then 
      m['titlepage-theme']["header-align"] = getVal(m['titlepage-theme']["page-align"])
  end
  if isEmpty(m['titlepage-theme']["footer-align"]) then 
      m['titlepage-theme']["footer-align"] = getVal(m['titlepage-theme']["page-align"])
  end
  if isEmpty(m['titlepage-theme']["logo-align"]) then 
      m['titlepage-theme']["logo-align"] = getVal(m['titlepage-theme']["page-align"])
  end
  if isEmpty(m['titlepage-theme']["vline-align"]) then 
      m['titlepage-theme']["vline-align"] = "left"
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
  
end -- end the theme section
  
  return m
  
end


