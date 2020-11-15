module JuliaCalc
  def julia_calc(object)
    # comp_const = complex(0,0)
    julia = {}

    x_array = Array.new(500) {|n| object[:min_x] + (object[:max_x]-object[:min_x])/500 * n}
    y_array = Array.new(500) {|n| object[:min_y] + (object[:max_y]-object[:min_y])/500 * n}
    comp_const = Complex(object[:real], object[:img])


    for i in 0..499 do
      for j in 0..499 do
        z0 = Complex(x_array[i],y_array[j])
        z1 = Complex(0,0)
        c = 1

        for n in 1..100 do
          z1=z0*z0 + comp_const

          if z1.abs>=2 then
            break
          end

          z0 = z1
          c+=1
        end

        julia["#{i}_#{j}"] = c
      end
    end

    render json: {status: "SUCCESS", data: julia}
  end
end
