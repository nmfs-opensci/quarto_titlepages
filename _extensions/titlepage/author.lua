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
  local author_table = {
    ["plain-no-and"] = function (m)
      m['titlepage-author-block'] = {
      "$for(by-author)$%",
      "{$by-author.name.literal$}%",
      "$sep$\\\\ %",
      "$endfor$%"}
    return m
  end
  }
  
  if not m['titlepage-author-theme'] then
    m['titlepage-author-theme'] = "plain-no-and"
  end
  choice = getVal(m['titlepage-author-theme'])
  if choice ~= "plain-no-and" and choice ~= "bg-image" and choice ~= "multi-purpose" and choice ~= "academic" and choice ~= "thesis"then
    error("titlepage extension error: titlepage can be vline, bg-image, multi-purpose, academic or thesis")
  end
  if isEmpty(choice) then
    author_table["plain-no-and"](m)
  else
    author_table[choice](m)
  end

  return m
  
end


