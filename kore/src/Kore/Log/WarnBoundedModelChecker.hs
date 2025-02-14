{-# LANGUAGE NoStrict #-}
{-# LANGUAGE NoStrictData #-}

{- |
Copyright   : (c) Runtime Verification, 2021
License     : BSD-3-Clause
-}
module Kore.Log.WarnBoundedModelChecker (
    WarnBoundedModelChecker (..),
    warnBoundedModelChecker,
) where

import Kore.Attribute.SourceLocation
import Kore.Internal.TermLike
import Kore.Rewrite.RulePattern (
    ImplicationRule,
 )
import Log
import Prelude.Kore
import Pretty (
    Pretty,
 )
import Pretty qualified

newtype WarnBoundedModelChecker
    = WarnBoundedModelChecker (ImplicationRule VariableName)
    deriving stock (Show)

instance Pretty WarnBoundedModelChecker where
    pretty (WarnBoundedModelChecker claim) =
        Pretty.hsep
            [ "The claim was not proven within the bound:"
            , Pretty.pretty (from @_ @SourceLocation claim)
            ]

instance Entry WarnBoundedModelChecker where
    entrySeverity _ = Warning
    oneLineDoc (WarnBoundedModelChecker rule) =
        Pretty.pretty @SourceLocation $ from rule
    helpDoc _ = "warn when the bounded model checker does not terminate within the given bound"

warnBoundedModelChecker ::
    MonadLog log =>
    ImplicationRule VariableName ->
    log ()
warnBoundedModelChecker claim =
    logEntry (WarnBoundedModelChecker claim)
