require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = req.params.merge(route_params)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    res.location=(url)
    res.status = 302
    session.store_session(res)
    raise "Error, response already built" if @already_built_response
    @already_built_response = res
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    res['Content-Type'] = content_type
    res.write(content)
    session.store_session(res)
    raise "Error, response already built" if @already_built_response
    @already_built_response = res
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    file = File.open("views/#{self.class.to_s.underscore}/#{template_name.to_s.underscore}.html.erb", "rb")
    contents = file.read
    template = ERB.new(contents)
    render_content(template.result(binding), 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)
    unless already_built_response?
      render name
    end
  end

  def flash
    @flash ||= Flash.new(req)
  end


end
