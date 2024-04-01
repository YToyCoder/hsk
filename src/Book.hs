module Book where
import Data.Char (GeneralCategory(NotAssigned))
import Data.List as LS ( find )
import qualified Data.List.NonEmpty as LS

data Book = Book { name:: String, id:: String }

type Books = [ Book ]

store :: Book -> Books -> Books
store b bs = b : bs

find :: String -> Books -> Maybe Book
find id = LS.find (\x -> name x == id)

remove :: String -> p -> LS.NonEmpty Book -> Books
remove id bs = LS.filter (\x -> name x == id)