using Digits
using Base.Test


# test data
n = 1234567890
p = 1234567890987654321
l = digits(n)
lp = digits(p)

# reversedigits
@test reversedigits(n) == reverse!(digits(n))
@test reversedigits(p) == digits(p)

# undigit
@test undigit(l) == n
@test undigit(n) == n
@test undigit(Int[]) == 0

# digithist
@test digithist(l) == [1,1,1,1,1,1,1,1,1,1]
@test digithist(n) == [1,1,1,1,1,1,1,1,1,1]
@test digithist(p) == [1,2,2,2,2,2,2,2,2,2]

# isanagram
@test isanagram(122334,431232) == true
@test isanagram(digits(122334),digits(431232)) == true
@test isanagram(122334,433232) == false
@test isanagram(135,61436) == false

# ispalindrom
@test ispalindrome(p) == true
@test ispalindrome(lp) == true
@test ispalindrome(n) == false

# contains
@test Digits.contains(n,n) == true
@test Digits.contains(n,3456) == true
@test Digits.contains(56,n) == true
@test Digits.contains(l,567) == true
@test Digits.contains(n,digits(123)) == true
@test Digits.contains(l,digits(789)) == true
@test Digits.contains(n,457) == false

# startswith
@test startswith(n,n) == true
@test startswith(n,123) == true
@test startswith(12,n) == true
@test startswith(l,1234) == true
@test startswith(l,digits(12)) == true
@test startswith(n,digits(1)) == true
@test startswith(n,2345) == false

# endswith
@test endswith(n,n) == true
@test endswith(n,7890) == true
@test endswith(90,n) == true
@test endswith(l,90) == true
@test endswith(l,digits(90)) == true
@test endswith(n,digits(567890)) == true
@test endswith(n,45678) == false

# crop
@test crop(n,3) == 4567890
@test crop(n,-4) == 123456
@test crop(l,5) == digits(67890)
@test crop(l,-8) == digits(12)
@test crop(n,10) == 0
@test crop(l,10) == [0]
@test crop(n,0) == n
@test crop(l,0) == l
@test_throws ErrorException crop(n,11)

# combine
@test combine(0,23) == 23
@test combine(11,0) == 110
@test combine(976,23) == 97623
@test combine(digits(234),digits(46)) == digits(23446)
@test combine(l,[0]) == digits(12345678900)
@test combine([0],l) == [l,0]
@test combine(Int[],l) == l
@test combine(l,Int[]) == l

# crosssum
@test crosssum(n) == 45
@test crosssum(lp) == 90
@test crosssum(0) == 0
@test crosssum(Int[]) == 0
@test crosssum([0]) == 0

# select
@test select(n,1:3) == 123
@test select(l,1:3) == [0,9,8]
@test select(n,[2,4]) == 24
@test select(l,[6,9]) == [5,2]

# replace and replace!
@test replace(n,[1],[9]) == 9234567890
@test replace(n,[3,7],[8,4]) == 1284564890
@test replace(n,5,1) == 1234167890
@test replace(n,[5:7],[1,2,3]) == 1234123890
@test replace(l,[3],[0]) == digits(1234567090)
@test replace(l,[9,1],[3,2]) == digits(1334567892)
@test replace(l,0,1) == digits(1234567891)
@test replace(l,[1:10],digits(9977553311)) == digits(9977553311)
ll = deepcopy(l)
replace!(ll,[2:3],[0,0])
@test ll == digits(1234567000)
replace!(ll,[9,8],[3,0])
@test ll == digits(1304567000)
replace!(ll,0,9)
@test ll == digits(1394567999)
