{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE TemplateHaskell     #-}
module Use() where

import TH (compile)

test = $$(compile [|| 0 ||])


