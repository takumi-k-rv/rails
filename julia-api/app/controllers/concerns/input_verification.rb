# coding: utf-8
module InputVerification
  def input_verification(object)
    status = 'SUCCESS'
    error_message = {}
    real=0
    img=0

    num = Regexp.new("^-?[0-9]+(\.[0-9]+)?$")

    unless object[:min_x].match(num) then # 数字以外ならエラー
      status = 'ERROR'
      error_message[:min_x] = "Invalid input of min_x.\n"
    end
    unless object[:max_x].match(num) then
      status = 'ERROR'
      error_message[:max_x] = "Invalid input of max_x.\n"
    end
    unless object[:min_y].match(num) then
      status = 'ERROR'
      error_message[:min_y] = "Invalid input of min_y.\n"
    end
    unless object[:max_y].match(num) then
      status = 'ERROR'
      error_message[:max_y] = "Invalid input of max_y.\n"
    end

    if object[:comp_const].match("^i$") # comp_const の処理
      real=0
      img=1
    elsif object[:comp_const].match("^-i$")
      real=0
      img=-1
    elsif object[:comp_const].match("^(-?[0-9]+(\.[0-9]+)?)\\+i$")
      real=$1
      img=1
    elsif object[:comp_const].match("^(-?[0-9]+(\.[0-9]+)?)-i$")
      real=$1
      img=-1
    elsif object[:comp_const].match("^(-?[0-9]+(\.[0-9]+)?)$")
      real=$1
      img=0
    elsif object[:comp_const].match("^(-?[0-9]+(\.[0-9]+)?)i$")
      real=0
      img=$1
    elsif object[:comp_const].match("^(-?[0-9]+(\.[0-9]+)?)\\+([0-9]+(\.[0-9]+)?)i$")
      real=$1
      img=$3
    elsif object[:comp_const].match("^(-?[0-9]+(\.[0-9]+)?)(-[0-9]+(\.[0-9]+)?)i$")
      real=$1
      img=$3
    else
      status = 'ERROR'
      error_message[:comp_const] = "Invalid input of comp_const.\n"
    end

    if status == 'SUCCESS' then
      if object[:min_x] >= object[:max_x] then # xの範囲
        status = 'ERROR'
        error_message[:x] = "Invalid input. min_x>=max_x.\n"
      end

      if object[:min_y] >= object[:max_y] then # yの範囲
        status = 'ERROR'
        error_message[:y] = "Invalid input. min_y>=max_y.\n"
      end
    end

    object.delete(:comp_const)
    object[:real] = real
    object[:img] = img

    if status == 'SUCCESS' then
      return object
    else
      render json: {status: 'ERROR', data: error_message}
      return false
    end
  end
end
