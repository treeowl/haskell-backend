{-# LANGUAGE CPP #-}
{-# LANGUAGE Unsafe #-}

-- | Before base 4.15.0, `unsafeCoerce` guarded by a condition could be
-- transformed unsafely by the compiler. See Note [Implementing unsafeCoerce]
-- in https://hackage.haskell.org/package/base-4.15.0.0/docs/src/Unsafe-Coerce.html
-- We use 'unsafeCoerce' in guarded fashions like
--
--   asConcrete t
--     | isConcrete t
--     = Just (unsafeCoerce t)
--     | otherwise
--     = Nothing
--
-- Therefore, we supply a copy of 'unsafeCoerce' that works around the problem
-- for older versions of GHC/base.
module Kore.Internal.UnsafeCoerce
  ( unsafeCoerceGuarded
  ) where
import Unsafe.Coerce (unsafeCoerce)

-- | A version of 'unsafeCoerce' that can be guarded by a condition regardless
-- of GHC version.
unsafeCoerceGuarded :: a -> b
unsafeCoerceGuarded = unsafeCoerce
#if MIN_VERSION_base(4,15,0)
{-# INLINE unsafeCoerceGuarded #-}
#else
{-# NOINLINE unsafeCoerceGuarded #-}
#endif
