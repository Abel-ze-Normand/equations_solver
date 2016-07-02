def iterations eps, q
  x, pred = 0, 1
  count = 0
  loop do
    x = phi pred
    break if (x - pred).abs < q/(1 - q)*eps
    pred = x
    count += 1
  end
  p "converges in #{count} iterations"
  return x
end

def func x
  return Math.atan(x) - 1/x + 2
end

def phi x
  return 1/(Math.atan(x) + 2)
end

def lambda_iter eps
  x, pred = 0.1, 1
  count = 0
  q = 1 - A/B
  loop do
    x = x - LAMBDA1 * func(x) 
    break if (x - pred).abs < q/(1 - q)*eps
    pred = x
    count += 1
  end

  p "Lambda monotonous method converges in #{count} iterations"
  p "root = #{x}"

  count = 0
  x, pred = 0.1, 1
  q = (B - A)/(A + B)
  loop do
    x = x - LAMBDA2 * func(x)
    break if (x - pred).abs < q/(1 - q)*eps
    pred = x
    count += 1
  end

  p "Lambda optimal method converges in #{count} iterations"
  p "root = #{x}"
end

def funcd x
  return 1/x**2 + 1/(1 + x**2)
end

B = funcd 0.2
A = funcd 1
LAMBDA1 = 1/B
LAMBDA2 = 2/(A + B)

p "root = #{iterations 10**-6, 0.2}, q = 0.2, eps = 10**-6"
p "root = #{iterations 10**-6, 0.4}, q = 0.4, eps = 10**-6"
p "root = #{iterations 10**-6, 0.6}, q = 0.6, eps = 10**-6"
lambda_iter 10**-6
