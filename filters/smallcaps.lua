
if FORMAT:match 'latex' then

function Strong(elem)
  return pandoc.SmallCaps(elem.c)
end

elseif FORMAT:match 'epub' then

function Strong(elem)
  local caps = {}
  for i = 1, #elem.c do
    local w = elem.c[i]
    if w.t == 'Str' then
      table.insert(caps, pandoc.Str(string.upper(w.c)))
    else
      table.insert(caps, w)
    end
  end
  return caps
end

end
