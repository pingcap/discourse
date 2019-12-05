# frozen_string_literal: true

class Jobs::ReviewablePriorities < Jobs::Scheduled
  every 1.day

  def execute(args)

    # We calculate the percentiles here for medium and high. Low is always 0 (all)
    res = DB.query_single(<<~SQL)
      SELECT score FROM reviewables
    SQL

    medium, high = percentile(res, 50), percentile(res, 85)

    Reviewable.set_priorities(medium: medium, high: high)
  end

  def percentile(arr, p)
    sorted_array = arr.sort
    return sorted_array.first if arr.length == 1
    return sorted_array.last if p == 100
    rank = (p.to_f / 100) * (arr.length)
    
    if arr.length == 0
      return 0
    elsif fractional_part?(rank)
      sorted_array[rank.ceil - 1]
    else
      sorted_array[rank - 1]
    end   
  end

  def fractional_part?(f)
    fractional_part(f) != 0.0
  end
  
  # Returns the fractional part of a float. For example, <tt>(6.67).fractional_part == 0.67</tt>
  def fractional_part(f)
    (f - f.truncate).abs
  end
end
