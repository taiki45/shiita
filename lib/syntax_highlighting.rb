class SyntaxHighlighting < Redcarpet::Render::HTML
  def block_code(code, language)
    language = :text unless language
    CodeRay.scan(code, language).div
  end
end
