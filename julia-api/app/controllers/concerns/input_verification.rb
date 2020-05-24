module InputVerification
  def input_verification(object)
    status = 'SUCCESS'
    error_message = {}

    num = Regexp.new("^-?[0-9]+(\.[0-9]+)?$")

    unless object[:min_x].match(num) then
      status = 'ERROR'
      error_message[:min_x] = 'Invalid input.'
    end
    unless object[:max_x].match(num) then
      status = 'ERROR'
      error_message[:max_x] = 'Invalid input.'
    end
    unless object[:min_y].match(num) then
      status = 'ERROR'
      error_message[:min_y] = 'Invalid input.'
    end
    unless object[:max_x].match(num) then
      status = 'ERROR'
      error_message[:max_y] = 'Invalid input.'
    end

    if status == 'SUCCESS' then
      return true
    else
      render json: {status: 'ERROR', data: error_message}
      return false
    end
  end
end
