-- this is a pragma inclusion:
{-# LANGUAGE OverloadedStrings #-}


-- the module name must coincide with the file name
module CheatSheet where


-- IMPORT statements:
-- import all into local namespace
import           Control.Monad
-- selective import
import           Data.Monoid   (Monoid)
-- qualified import; use L.theName
import qualified Data.List     as L


-- VALUE declaration:
someInt :: Int                        -- type declaration
someInt = 5                           -- value assignment

someBool :: Bool
someBool = True -- (or False)

someChar :: Char
someChar = 'c'

someString :: String
someString = "This is a String."


-- FUNCTION declaration:                                             !!!!!!!!!!!!!!!
someIntFunction :: Int -> Int           -- function types flow with `->`
someIntFunction 0 = c                   -- base function clause ('base pattern match')
    where c = 15                        -- where clause for local names
someIntFunction x = x + 1               -- second function clause
someIntFunction _ = undefined           -- final catchall clause
-- NOTE: not covering all patterns leads to runtime crashing!

-- calling:
functionCallResult :: Int
functionCallResult = someIntFunction 100 -- NOTE: no parens needed

-- PREFIX vs. INFIX:
prefixAdd :: Int -> Int -> Int
prefixAdd a b = a + b

n, n':: Int
n = prefixAdd 2 2
n' = 2 `prefixAdd` 2

-- infix add:
(+:+) :: Int -> Int -> Int
a +:+ b = a + b

m, m' :: Int
m = 2 +:+ 2
m' = (+:+) 2 2


-- LIST manipulation(s):
someList :: [Int]
someList = [1..10]

someOtherList :: [Int]
someOtherList = 1 : [2..10]             -- list constructor (Int -> [Int] -> [Int])

someOtherOtherList :: [Int]
someOtherOtherList = [1..5] ++ [6..10]  -- list concatenation

someListHeadFunction :: [Int] -> Int
someListHeadFunction (head:rest) = head -- we can deconstruct datatypes directly
                                        -- within the pattern matching of a clause
someListHeadFunction _ = error "The list is empty!"


-- PARAMETRIC POLYMORPHISM                                                  !!!!!!!!!!!!!!!!!!!!!
-- comparable to the generics in the heavier OOP languages (Java, C#)
-- allows for defining highly generic implementations for massive
-- reuse gains. Most straightforward example is the list length function:
myLength :: [a] -> Int
myLength [] = 0
myLength (head : rest) = 1 + (length rest)
-- the reasoning is that we do not care at all what is in the list, that's why
-- we use the TYPE VARIABLE 'a', which allows us to work over all lists
-- regardless of what type of element is in it; but prevents us from making any
-- assuptions about what is in it.


-- TYPES:

-- type synonim; PersonName and String can be used interchangeably...
type PersonName = String

-- data declaration, ADT-capable:
data Person = PersonC PersonName
-- NOTES on the terminology:
-- Person = type name (aka type constructor for higher kinded types)
-- PersonC = value constructor
--         imagine PersonC is a function (it is btw) which, given a
--         PersonName, returns a value of type Person
-- it is possible (and even standard practice)  to use the same name
-- for both the type and the value constructor.
simonPeytonJones :: Person
simonPeytonJones = PersonC "Simon Peyton Jones"

-- a newtype is like a type synomim; but can NOT be used interchangeably:
newtype PersonNameNT = PersonNameNT String
-- ^ note the use of the same name for both the type and value constructors


-- ADT's (Algebraic Data Types):
type Age = Int
data PersonDescription = PersonDescriptionC PersonName Age | MissingPersonDescriptionC
-- think of adt's as a cross between:
--      structs (look at PersonDescriptionC)
--      enums (look at MissingPersonDescriptionC, ex: `data Bool = True | False`)
--      unions (a value of type PersonDescription can either be constructed
--      using PersonDescriptionC, or MissingPersonDescriptionC)

-- NOTE: both these two values are of type PersonDescription:
simonsDescription :: PersonDescription
simonsDescription = PersonDescriptionC "Simon Peyton Jones" 58

missingPersonDescription :: PersonDescription
missingPersonDescription = MissingPersonDescriptionC

-- example usage:
-- getPersonDescription returns a String representation of a PersonDescription
getPersonDescription :: PersonDescription -> String
getPersonDescription (PersonDescriptionC name age) = "His/her name is " ++ name ++ " and he/she is " ++ (show age) ++ " years old."
getPersonDescription MissingPersonDescriptionC = "No info available."


-- TYPECLASSES:

-- Typeclasses are best compared to the interfaces people are used to in OOP;
-- they define behaviour(s) associated to a specific type.
class MyEquatable a where
    -- you just provide the signatures of the 'properties':
    areEqual :: a -> a -> Bool

    areNotEqual :: a -> a -> Bool
    areNotEqual x y = not (areEqual x y)    -- we can provide default implementations


newtype NumberOfParticipants = NumberOfParticipants Int

-- NOTE: instance declaration (aka the 'implementation' of the properties), is
-- separate from both the type we are instantiating and the class's declaration:
instance MyEquatable NumberOfParticipants where
    areEqual (NumberOfParticipants x) (NumberOfParticipants y) = (x == y)


-- extras: Functor, Applicative and Monad: ASK PLEASES!!!
