class FacebookAuthServer < TCPServer
  def serve_and_extract_access_token_from_user_agent_flow
    serve_content_and_return_request(%Q{
      <script>
        window.location.replace(window.location.toString().replace('#', '?'));
      </script>})

    request = serve_content_and_return_request(%q{
      Success! You can now close this window and return to FacebookCL.
      <script>
        window.close();
      </script>})

    extract_access_token_from_request(request)
  end

  private

  HTTP_HEADER = "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"

  def serve_content_and_return_request(content)
    session = accept
    session.print HTTP_HEADER

    request = session.gets.strip

    session.print(content)
    session.close

    request
  end

  def extract_access_token_from_request(request)
    request.gsub(/^GET \/\?access_token=/, '').gsub(/ HTTP.*$/, '')
  end
end