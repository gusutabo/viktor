# frozen_string_literal: true

class Health
  def bmi(weight, height)
    (weight.to_f / height**2).round(2)
  end

  def bmi_category(bmi)
    case bmi
    when 0...18.5  then :underweight
    when 18.5...25 then :healthy
    when 25...30   then :overweight
    when 30...35   then :obese1
    when 35...40   then :obese2
    else                :obese3
    end
  end
end
