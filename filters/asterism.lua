if FORMAT:match 'latex' or FORMAT:match 'json' then
  function HorizontalRule()
    local asterism_png = os.getenv('ASTERISM_PNG')
    -- io.stderr:write('in HorizontalRule function\n')
    local asterism = '\\begin{center}\\includegraphics{images/' .. asterism_png .. '}\\end{center}'
    -- io.stderr:write(asterism .. '\n')
    return pandoc.RawBlock('latex', asterism)
  end
end
