class SyntaxHighlighting < Redcarpet::Render::HTML
  def block_code(code, language)
    if %w(tex asciimath mml).include? language
        %(<script type="math/#{language}; mode=display">#{code}</script>)
    else
      language = :text unless CodeRay::Scanners.list.include? (language && language.to_sym)
      CodeRay.scan(code, language).div
    end
  end
end
