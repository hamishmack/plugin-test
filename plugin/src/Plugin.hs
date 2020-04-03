module Plugin (plugin) where

import qualified GhcPlugins                             as GHC

plugin :: GHC.Plugin
plugin = GHC.defaultPlugin { GHC.installCoreToDos = install, GHC.pluginRecompile = GHC.flagRecompile }

install :: [GHC.CommandLineOption] -> [GHC.CoreToDo] -> GHC.CoreM [GHC.CoreToDo]
install args = pure


