
--[[

  Algorithm description:

  Basically just long division. Specifics are described in comments in the code.

  This was a really fun project because I had to break down long division and rebuild it from scratch.
  
  Only accepts two polynomials where the dividend(number being divided) is greater than  or equal to the divisor(number beind divided by)
]]

local function Divide(DividendCoefList, DivisorCoefList)
    local DividendDegree = #DividendCoefList
    local DivisorDegree = #DivisorCoefList
    local SolutionCoefList = {}
    if DivisorDegree > DividendDegree then
        print("Degree of Divisor is Greater than that of Dividend")
        os.exit()  
     else

        local SolutionDegree = DividendDegree - DivisorDegree
        --We know that the degree of the quotient is going to be the difference between the dividend degree and the divisor degree (I learned this through just trying it)


        --clc stands for current leading coefficient, it is what you try to fit your divisor's leading coefficient(lc) in when you are doing long division.
        for clc = DividendDegree, DivisorDegree, -1 do
            frac = DividendCoefList[clc] / DivisorCoefList[DivisorDegree]
            print(frac)
            print(clc)
            --finds the next solution(quotient) coefficient by fitting the divisor's lc into the dividend clc

            SolutionCoefList[SolutionDegree - (DividendDegree - clc)] = frac


            --these two loops get rid of the clc in the dividendCoefList, and multiplies the rest of the coefficients around the ratio of the clc to the lc of the divisor. This is the same as carrying the result down like you do in long division.
            temp = {}
            for i = DivisorDegree, 0, -1 do
                temp[i] = DivisorCoefList[i] * frac
            end

            for i = clc, clc - DivisorDegree, -1 do
                DividendCoefList[i] = DividendCoefList[i] - temp[DivisorDegree - (clc - i)]  
            end
        end


        return SolutionCoefList, DividendCoefList, DivisorCoefList
    end
end
 
 
 
local function printPoly(poly)
  if(poly[#poly] ~= nil) then
    io.write(poly[#poly])
    io.write(" x^" .. tostring(#poly) .. "  ")
  else
     return
  end

  for i = #poly - 1, 0, -1 do
      if(poly[i] ~= nil) then
        io.write("+  ")
        io.write(poly[i])
        io.write(" x^" .. tostring(i) .. "  ")
      else
        return
      end
  end
  print()
end
 
 
 
 
 
io.write("enter the degree of the Dividend:")
local dividendD = io.read("*n")
io.write("enter the degree of the Divisor:")
local divisorD = io.read("*n")
 
 
 
if type(dividendD) ~= "number" or type(divisorD) ~= "number" then
    print("\n \nInput must be a number")
    os.exit()
    print()
end
 
io.write("input every coefficient of the dividend polynomial in descending order from highest power:\n")
 
local dividendCoefs = {}
for i = dividendD, 0, -1 do
    dividendCoefs[i] = io.read("*n")
    if(type(dividendCoefs[i]) ~= "number") then
        print("Input must be a number")
        os.exit()
    end
end
 
io.write("input every coefficient of the divisor polynomial in descending order from highest power:\n")    
 
 
 
local divisorCoefs = {}
for i = divisorD, 0, -1 do
    divisorCoefs[i] = io.read("*n")
    if(type(divisorCoefs[i]) ~= "number") then
        print("Input must be a number")
        os.exit()
    end
end
io.read()
 
 
 
solution, remainder, divisor = Divide(dividendCoefs, divisorCoefs)
 
even = true
for i,v in pairs(remainder) do
    if v ~= 0 then
        even = false
    end
end
 
 
if even then
    print()
    print("Evenly divisible!")
    print()
end
 
print("the coefs of the solution are: ")
print()
printPoly(solution)
print()
 
if even ~= true then
    print("with a remainder of: ")
    print()
    printPoly(remainder)
    io.write("divided by ")
    printPoly(divisor)
    print()
end
io.write("Press enter")
io.read()