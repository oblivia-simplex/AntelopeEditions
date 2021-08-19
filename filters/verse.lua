if FORMAT:match 'latex' then

  function LineBlock(elem)
    local text = ''
    for line_num = 1, #elem.c do
      local line = elem.c[line_num]
      local row = ''
      for i = 1, #line do
        if line[i].t == 'Space' then
          row = row .. ' '
        elseif line[i].t == 'Str' then
          row = row .. line[i].c
        elseif line[i].t == 'Emph' then
          local emph = ''
          for j = 1, #line[i].c do
            local w = line[i].c[j]
            if w.t == 'Space' then
              emph = emph .. ' '
            else
              emph = emph .. w.c
            end
          end
          row = row .. '\\emph{' .. emph .. '}'
        end
      end
      text = text .. row .. '\\\\\n'
    end
    verse = '\\begin{verse}\n' .. text .. '\\end{verse}\n'
    return pandoc.RawBlock('latex', verse)
  end

end
