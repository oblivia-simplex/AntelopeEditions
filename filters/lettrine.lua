if FORMAT:match 'latex' or FORMAT:match 'json' then

  BEGINNING_OF_CHAPTER = 0

  function Header(elem)
    if elem.c[1] == 1 then
      BEGINNING_OF_CHAPTER = 1
    end
  end

  function Para(elem)
    if BEGINNING_OF_CHAPTER == 0 then
      return
    end
    local first = elem.c[1]
    if first.t == 'SmallCaps' and first.c[1].t == 'Str' then
      BEGINNING_OF_CHAPTER = 0
      local word = first.c[1].c
      -- io.stderr:write('first SmallCaps word: ' .. word .. '\n')
      local initial = string.sub(word, 1, 1)
      local len = string.len(word)
      local rest = string.sub(word, 2)
      for i=2,#first.c do
        if first.c[i].t == 'Space' then
          rest = rest .. ' '
        else
          rest = rest .. first.c[i].c
        end
      end
      -- io.stderr:write('initial: ' .. initial .. ', len: ' .. len .. ', rest: ' .. rest .. '\n')
      local lettrine = '\\lettrine[lines=3, findent=0em, nindent=0.1em, lhang=0]{' .. initial .. '}{' .. rest .. '}'
      -- io.stderr:write('TEX: ' .. lettrine .. '\n')
      elem.c[1] = pandoc.RawInline('latex', lettrine)
      return elem
    else
      return elem
    end
  end

end
