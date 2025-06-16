-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for all tables with updated_at
DO $$ 
DECLARE
  t text;
BEGIN
  FOR t IN 
    SELECT table_name 
    FROM information_schema.columns 
    WHERE column_name = 'updated_at' 
    AND table_schema = 'public'
  LOOP
    EXECUTE format('DROP TRIGGER IF EXISTS update_%I_updated_at ON %I', t, t);
    EXECUTE format('CREATE TRIGGER update_%I_updated_at BEFORE UPDATE ON %I FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()', t, t);
  END LOOP;
END $$;

-- Update handle_new_user function to handle existing users
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, subscription_tier, trial_ends_at)
  VALUES (
    NEW.id,
    NEW.email,
    'trial',
    NOW() + INTERVAL '30 days'
  )
  ON CONFLICT (id) DO UPDATE
  SET 
    email = EXCLUDED.email,
    subscription_tier = COALESCE(profiles.subscription_tier, EXCLUDED.subscription_tier),
    trial_ends_at = COALESCE(profiles.trial_ends_at, EXCLUDED.trial_ends_at);
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create or replace the trigger
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- Function to check if user has premium access
CREATE OR REPLACE FUNCTION is_premium_user(user_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
  user_tier TEXT;
  trial_end TIMESTAMPTZ;
BEGIN
  SELECT subscription_tier, trial_ends_at 
  INTO user_tier, trial_end
  FROM profiles 
  WHERE id = user_id;
  
  IF user_tier = 'premium' THEN
    RETURN TRUE;
  ELSIF user_tier = 'trial' AND trial_end > NOW() THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Function to get days until trial ends
CREATE OR REPLACE FUNCTION days_until_trial_ends(user_id UUID)
RETURNS INTEGER AS $$
DECLARE
  trial_end TIMESTAMPTZ;
  user_tier TEXT;
BEGIN
  SELECT trial_ends_at, subscription_tier
  INTO trial_end, user_tier
  FROM profiles 
  WHERE id = user_id;
  
  IF user_tier != 'trial' OR trial_end IS NULL THEN
    RETURN NULL;
  END IF;
  
  RETURN GREATEST(0, EXTRACT(DAY FROM trial_end - NOW())::INTEGER);
END;
$$ LANGUAGE plpgsql;

-- Function to calculate total savings
CREATE OR REPLACE FUNCTION calculate_total_savings(user_id UUID, period_days INTEGER DEFAULT 30)
RETURNS DECIMAL AS $$
DECLARE
  total DECIMAL;
BEGIN
  SELECT COALESCE(SUM(savings_amount), 0)
  INTO total
  FROM savings_opportunities
  WHERE savings_opportunities.user_id = calculate_total_savings.user_id
  AND is_used = true
  AND used_at >= NOW() - (period_days || ' days')::INTERVAL;
  
  RETURN total;
END;
$$ LANGUAGE plpgsql;

-- Function to get household members
CREATE OR REPLACE FUNCTION get_household_members(household_id UUID)
RETURNS TABLE(user_id UUID, email TEXT, display_name TEXT, role TEXT) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    hm.user_id,
    p.email,
    p.display_name,
    hm.role
  FROM household_members hm
  JOIN profiles p ON p.id = hm.user_id
  WHERE hm.household_id = get_household_members.household_id;
END;
$$ LANGUAGE plpgsql;