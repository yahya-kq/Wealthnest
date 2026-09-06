-- =============================================================================
-- WealthNest: Complete Account & Data Deletion Function (RPC)
-- =============================================================================
-- Run this script in your Supabase Dashboard -> SQL Editor.
-- This function allows authenticated users to permanently delete their own 
-- account and all associated personal financial data.
-- =============================================================================

-- 1. Create or replace the delete_user_account RPC function
CREATE OR REPLACE FUNCTION public.delete_user_account()
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, auth
AS $$
DECLARE
  calling_user_id uuid;
BEGIN
  -- Retrieve the authenticated user ID from context
  calling_user_id := auth.uid();

  -- Safeguard: Ensure calling user exists
  IF calling_user_id IS NULL THEN
    RAISE EXCEPTION 'Not authorized. You must be signed in to delete your account.';
  END IF;

  -- 1. Delete user's financial transactions, budgets, goals & settings
  DELETE FROM public.user_finances
  WHERE user_id = calling_user_id;

  -- 2. Delete user profile
  DELETE FROM public.profiles
  WHERE id = calling_user_id;

  -- 3. Delete authentication credentials from Supabase auth.users
  DELETE FROM auth.users
  WHERE id = calling_user_id;

  RETURN true;
END;
$$;

-- 2. Grant execute permissions to authenticated users
REVOKE ALL ON FUNCTION public.delete_user_account() FROM public;
GRANT EXECUTE ON FUNCTION public.delete_user_account() TO authenticated;

-- Comment for documentation
COMMENT ON FUNCTION public.delete_user_account() IS 
  'Securely deletes the calling user financial data, profile, and auth record from WealthNest.';
