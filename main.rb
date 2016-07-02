require 'tty'
def bisect a, b, eps
  x, pred, mid = 0, 0, 0
  k = 0
  loop do
    mid = (a+b)/2.0
    x = func(mid)
    if func(mid) == 0 then 
      x = func(mid)
      break
    end
    if (func(a) * func(mid)) < 0
      b = mid
    elsif (func(mid) * func(b)) < 0
           a = mid
    end
    if (eps > (x - pred).abs) then
      break
    else 
      pred = x
      k += 1
    end
  end
  err = check mid
  return mid, k, err
end

def chord a, b, eps
  x, pred, k = 0, 0, 0;
  loop do
    x = func(a)/(func(b) - func(a))*(a-b)+a
    if (x-pred).abs < eps then break
    else 
      if func(a) * funcdd(a) > 0 then b = x
      elsif func(b) * funcdd(b) > 0 then a = x
      end
      pred = x
      k += 1
    end
  end
  err = check x
  return x, k, err
end

def neuton a, b, eps
  if func(a) * funcdd(a) > 0 then 
    x = a
    flag = "a"
  else 
    x = b
    flag = "b"
  end
  k = 0
  loop do
    pred = x
    if flag == "a" then
      x = pred - func(pred)/funcd(pred)
    else
      x = pred + func(pred)/funcd(pred)
    end
    break if (x-pred).abs < eps
    k += 1
  end
  err = check x
  return x, k, err
end

def secant a, b, eps
  if func(a) * funcdd(a) > 0 then 
    x0 = a
    x1 = x0 + 0.1
    flag = "a"
  else 
    x0 = b
    x1 = x0 - 0.1
    flag = "b"
  end
  
  x, pred, k = 0, 0, 0
  loop do 
    if flag == "a" then
      x = x1 - func(x1) * (x1 - x0) / (func(x1) - func(x0))
    else 
      x = x1 + func(x1) * (x1 - x0) / (func(x1) - func(x0))
    end
    if (x-pred).abs < eps then break
    else
      pred = x
      x0 = x1
      x1 = x
      k += 1
    end
  end
  err = check x
  return x, k, err
end

def check x
  (func(x) - 0).abs
end

def func x
  return 2**x**2 - 1/x
end

def funcd x
  return 1/x**2  + 2**x**2 * x * Math.log(2)
end

def funcdd x
  return -2/(x**3) + 2**(x**2 + 2) * x**2 * Math.log(2)**2 + 2**(x**2 + 1) * Math.log(2)
end

#eps = 10**-5
#p "eps = #{eps}"
#p "root by bisect = #{bisect 0.1, 1.0, eps}"
#p ""
#p "root by chord = #{chord 0.1, 1.0, eps}"
#p ""
#p "root by neuton = #{neuton 0.1, 1.0, eps}"
#p ""
#p "root by secant = #{secant 0.1, 1.0, eps}"
#p ""

eps = 10**-3

fx, k, err = bisect 0.1, 1.0, eps
fields = [["Bisect", 0.1, fx, k, eps, err]]
fx, k, err = chord 0.1, 1.0, eps
fields << ["Chord", 0.1, fx, k, eps, err]
fx, k, err = neuton 0.1, 1.0, eps
fields << ["Neuton", 0.1, fx, k, eps, err]
fx, k, err = secant 0.1, 1.0, eps
fields << ["Secant", 0.1, fx, k, eps, err]

t = TTY::Table.new ["Method", "x0", "root", "Iterations", "eps", "err"], fields
puts t.render(:ascii)
eps = 10**-5

fx, k, err = bisect 0.1, 1.0, eps
fields = [["Bisect", 0.1, fx, k, eps, err]]
fx, k, err = chord 0.1, 1.0, eps
fields << ["Chord", 0.1, fx, k, eps, err]
fx, k, err = neuton 0.1, 1.0, eps
fields << ["Neuton", 0.1, fx, k, eps, err]
fx, k, err = secant 0.1, 1.0, eps
fields << ["Secant", 0.1, fx, k, eps, err]

t = TTY::Table.new ["Method", "x0", "root", "Iterations", "eps", "err"], fields
puts t.render(:ascii)
eps = 10**-8

fx, k, err = bisect 0.1, 1.0, eps
fields = [["Bisect", 0.1, fx, k, eps, err]]
fx, k, err = chord 0.1, 1.0, eps
fields << ["Chord", 0.1, fx, k, eps, err]
fx, k, err = neuton 0.1, 1.0, eps
fields << ["Neuton", 0.1, fx, k, eps, err]
fx, k, err = secant 0.1, 1.0, eps
fields << ["Secant", 0.1, fx, k, eps, err]

t = TTY::Table.new ["Method", "x0", "root", "Iterations", "eps", "err"], fields
puts t.render(:ascii)
