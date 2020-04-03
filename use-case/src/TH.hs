{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE TemplateHaskell  #-}
{-# LANGUAGE TypeApplications #-}
module TH (
    compile
    ) where

import qualified Language.Haskell.TH            as TH
import qualified Language.Haskell.TH.Syntax     as TH

compile :: TH.Q (TH.TExp a) -> TH.Q (TH.TExp a)
compile e = do
    TH.addCorePlugin "Plugin"
    e

