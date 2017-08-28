class Array

  def pick_stock
    best_days = [0, 1]
    self.each_with_index do |buy, buy_ind|
      break if buy_ind + 1 == self.length
      self.each_with_index do |sell, sell_ind|
        next if sell_ind < buy_ind
        if (sell - buy) > (self[best_days.last] - self[best_days.first])
          best_days = [buy_ind, sell_ind]
        end
      end
    end
    best_days
  end
end
