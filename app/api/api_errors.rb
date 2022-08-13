module ApiErrors 
  class ApiExceptionError < RuntimeError; end

  class BadRequest < ApiExceptionError; end
end