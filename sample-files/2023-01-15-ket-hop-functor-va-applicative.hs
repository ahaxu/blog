module X where

newtype FirstName = FirstName String deriving Show
newtype LastName = LastName String deriving Show
newtype Grade = Grade String deriving Show
newtype Address = Address String deriving Show


data Student =  Student
    {
        firstName :: FirstName,
        lastName :: LastName,
        grade :: Grade,
        address :: Address
    } deriving (Show)


