module Julia
  def julia(object)
    # comp_const = complex(0,0)
    hash = {}

    for i in 0..499 do
      for j in 0..499 do
    #     z0 = complex(i,j)
    #     z1 = complex(0,0)
    #     c = 1

    #     for n in 1..100 do
    #       z1=z0*z0 + comp_const
    #       if z1.abs>2 then
    #         break
    #       end
    #       z0=z1
    #       c++
    #     end

        #
        hash["#{i}_#{j}"] = rand(1..100)
      end
    end

    render json: {status: 'SUCCESS', data: hash}
  end
end
