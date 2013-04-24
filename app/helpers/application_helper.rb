module ApplicationHelper
  def markdown(text)
    redcarpet.render(text).html_safe
  end

  def login_path
    'auth/google_oauth2'
  end

  private

  def redcarpet
    @redcarpet ||= Redcarpet::Markdown.new(
      SyntaxHighlighting.new(
        filter_html: true,
        hard_wrap:true
      ),
      fenced_code_blocks: true,
      autolink: true
    )
  end
end
