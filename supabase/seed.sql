-- Seed data for ChaiChu (nexcord)

-- Insert demo server and categories (to be populated when migration is active)
-- Initial permissions bitmask constants and helper functions
CREATE OR REPLACE FUNCTION public.has_permission(user_permissions BIGINT, required_permission BIGINT)
RETURNS BOOLEAN AS $$
BEGIN
    -- Administrator permission is 1 (1 << 0)
    IF (user_permissions & 1) = 1 THEN
        RETURN TRUE;
    END IF;
    RETURN (user_permissions & required_permission) = required_permission;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
