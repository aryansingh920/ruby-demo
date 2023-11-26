require 'webrick'

class SimpleServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    case request.path
    when '/'
      home_page(response)
    when '/greet'
      greet_page(response)
    else
      not_found_page(response)
    end
  end

  def do_POST(request, response)
    case request.path
    when '/submit'
      submit_form(request, response)
    else
      not_found_page(response)
    end
  end

  private

  def home_page(response)
    response.status = 200
    response.content_type = 'text/html'
    response.body = '<html><body><h1>Hello, World!</h1></body></html>'
  end

  def greet_page(response)
    response.status = 200
    response.content_type = 'text/html'
    response.body = '<html><body><h1>Welcome to the Greet Page!</h1></body></html>'
  end

  def not_found_page(response)
    response.status = 404
    response.content_type = 'text/html'
    response.body = '<html><body><h1>404 Not Found</h1></body></html>'
  end

  def submit_form(request, response)
    # Retrieve and process data from the POST request, if needed
    submitted_data = request.query['data']

    response.status = 200
    response.content_type = 'text/html'
    response.body = "<html><body><h1>Form Submitted!</h1><p>Data received: #{submitted_data}</p></body></html>"
  end
end

server = WEBrick::HTTPServer.new(Port: 8000)
server.mount('/', SimpleServlet)
trap('INT') { server.shutdown }
server.start
