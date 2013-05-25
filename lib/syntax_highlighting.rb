class SyntaxHighlighting < Redcarpet::Render::HTML
  def block_code(code, language)
    language = :text unless language
    if language == 'mathjax'
      %(<script type="math/tex; mode=display">#{code}</script>)
    else
      CodeRay.scan(code, language).div
    end
  end
end
