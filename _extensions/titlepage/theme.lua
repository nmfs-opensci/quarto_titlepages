local function isEmpty(s)
  return s == nil or s == ''
end

function Meta(m)
  local theme_table = {
    ["academic-static"] = function (m)
      m['academic-static'] = true
      return m
    end,
    ["bg-image"] = function (m)
      m['bg-image'] = true
      if isEmpty(m['title-bg-image']) then
        m['title-bg-image'] = "corner-bg.png"
      end
      if isEmpty(m['title-bg-location']) then
        m['title-bg-location'] = "UL"
      end
      if isEmpty(m['title-bg-size']) then
        m['title-bg-size'] = 0.5
      end
      if isEmpty(m['titlepage-geometry']) then
        m['titlepage-geometry'] = pandoc.List({"top=3in", "bottom=1in", "right=1in", "left=1in"})
      end
      return m
    end,
    ["classic-lined-static"] = function (m)
      m['classic-lined-static'] = true
      if isEmpty(m['logo']) then
        m['logo'] = "logo.png"
      end
      return m
    end,
    ["great-wave"] = function (m)
      m['great-wave'] = true
      if isEmpty(m['title-bg-image']) then
        m['title-bg-image'] = "TheGreatWaveoffKanagawa.jpeg"
      end
      if isEmpty(m['title-page-color']) then
        m['title-page-color'] = "F6D5A8"
      end
      return m
    end,
    ["multi-purpose"] = function (m)
      m['multi-purpose'] = true
      if isEmpty(m['logo']) then
        m['logo'] = "logo.png"
      end
      return m
    end,
    ["multi-purpose-static"] = function (m)
      m['multi-purpose-static'] = true
      if isEmpty(m['logo']) then
        m['logo'] = "logo.png"
      end
      return m
    end,
    ["thesis-static"] = function (m)
      m['thesis-static'] = true
      if isEmpty(m['logo']) then
        m['logo'] = "logo.png"
      end
      return m
    end,
    ["vline"] = function (m)
      m['vline'] = true
      if isEmpty(m['logo']) then
        m['logo'] = "logo.png"
      end
      return m
    end,
    ["vline-static"] = function (m)
      m['vline-static'] = true
      if isEmpty(m['logo']) then
        m['logo'] = "logo.png"
      end
      return m
    end
  }

  if not m.titlepage then
    m['titlepage'] = "vline"
  end
  choice = pandoc.utils.stringify(m.titlepage)
  if isEmpty(choice) then
    return theme_table["vline"](m)
  else
    return theme_table[choice](m)
  end
end
