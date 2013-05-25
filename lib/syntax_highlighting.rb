class SyntaxHighlighting < Redcarpet::Render::HTML
  def block_code(code, language)
    if %w(tex latex).include? language
        %(<script type="math/tex; mode=display">#{code}</script>)
    else
      language = :text unless CodeRay::Scanners.list.include? (language && language.to_sym)
      CodeRay.scan(code, language).div
    end
  end


  def codespan(code)
    if code.length > 2 && code[0] == "$" && code[-1] == "$"
      code.gsub!(/^\$/,'')
      code.gsub!(/\$$/,'')
      "<script type=\"math/tex\">#{code}</script>"
    else
      "<code>#{code}</code>"
    end
  end
end
