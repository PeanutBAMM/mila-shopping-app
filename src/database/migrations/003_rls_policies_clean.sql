-- Drop existing policies to avoid conflicts
DO $$ 
DECLARE
  r RECORD;
BEGIN
  FOR r IN SELECT tablename, policyname FROM pg_policies WHERE schemaname = 'public'
  LOOP
    EXECUTE format('DROP POLICY IF EXISTS %I ON %I', r.policyname, r.tablename);
  END LOOP;
END $$;

-- Profiles policies
CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);

-- Households policies
CREATE POLICY "Users can view households they belong to" ON households
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM household_members 
      WHERE household_members.household_id = households.id 
      AND household_members.user_id = auth.uid()
    )
  );

CREATE POLICY "Household owners can update" ON households
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM household_members 
      WHERE household_members.household_id = households.id 
      AND household_members.user_id = auth.uid()
      AND household_members.role IN ('owner', 'admin')
    )
  );

CREATE POLICY "Users can create households" ON households
  FOR INSERT WITH CHECK (auth.uid() = created_by);

-- Household members policies
CREATE POLICY "Household members can view members" ON household_members
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM household_members hm2 
      WHERE hm2.household_id = household_members.household_id 
      AND hm2.user_id = auth.uid()
    )
  );

CREATE POLICY "Household admins can manage members" ON household_members
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM household_members hm2 
      WHERE hm2.household_id = household_members.household_id 
      AND hm2.user_id = auth.uid()
      AND hm2.role IN ('owner', 'admin')
    )
  );

-- Shopping lists policies
CREATE POLICY "Users can view own and household lists" ON shopping_lists
  FOR SELECT USING (
    user_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM household_members 
      WHERE household_members.household_id = shopping_lists.household_id 
      AND household_members.user_id = auth.uid()
    ) OR
    EXISTS (
      SELECT 1 FROM shared_lists 
      WHERE shared_lists.shopping_list_id = shopping_lists.id 
      AND shared_lists.shared_with_user_id = auth.uid()
    )
  );

CREATE POLICY "Users can create lists" ON shopping_lists
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "List owners and editors can update" ON shopping_lists
  FOR UPDATE USING (
    user_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM shared_lists 
      WHERE shared_lists.shopping_list_id = shopping_lists.id 
      AND shared_lists.shared_with_user_id = auth.uid()
      AND shared_lists.permission = 'edit'
    )
  );

CREATE POLICY "List owners can delete" ON shopping_lists
  FOR DELETE USING (user_id = auth.uid());

-- Shopping items policies
CREATE POLICY "Users can view items in accessible lists" ON shopping_items
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM shopping_lists 
      WHERE shopping_lists.id = shopping_items.shopping_list_id
      AND (
        shopping_lists.user_id = auth.uid() OR
        EXISTS (
          SELECT 1 FROM household_members 
          WHERE household_members.household_id = shopping_lists.household_id 
          AND household_members.user_id = auth.uid()
        ) OR
        EXISTS (
          SELECT 1 FROM shared_lists 
          WHERE shared_lists.shopping_list_id = shopping_lists.id 
          AND shared_lists.shared_with_user_id = auth.uid()
        )
      )
    )
  );

CREATE POLICY "Users can manage items in editable lists" ON shopping_items
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM shopping_lists 
      WHERE shopping_lists.id = shopping_items.shopping_list_id
      AND (
        shopping_lists.user_id = auth.uid() OR
        EXISTS (
          SELECT 1 FROM shared_lists 
          WHERE shared_lists.shopping_list_id = shopping_lists.id 
          AND shared_lists.shared_with_user_id = auth.uid()
          AND shared_lists.permission = 'edit'
        )
      )
    )
  );

-- Stores policies (public read)
CREATE POLICY "Anyone can view stores" ON stores
  FOR SELECT USING (true);

-- Products policies (public read)
CREATE POLICY "Anyone can view products" ON products
  FOR SELECT USING (true);

-- Product prices policies (public read)
CREATE POLICY "Anyone can view prices" ON product_prices
  FOR SELECT USING (true);

-- Product suggestions policies (public read)
CREATE POLICY "Anyone can view suggestions" ON product_suggestions
  FOR SELECT USING (true);

-- Recipes policies
CREATE POLICY "Users can view own and household recipes" ON recipes
  FOR SELECT USING (
    user_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM household_members 
      WHERE household_members.household_id = recipes.household_id 
      AND household_members.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can create recipes" ON recipes
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Recipe owners can update" ON recipes
  FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "Recipe owners can delete" ON recipes
  FOR DELETE USING (user_id = auth.uid());

-- Recipe ingredients policies
CREATE POLICY "Users can view ingredients of accessible recipes" ON recipe_ingredients
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM recipes 
      WHERE recipes.id = recipe_ingredients.recipe_id
      AND (
        recipes.user_id = auth.uid() OR
        EXISTS (
          SELECT 1 FROM household_members 
          WHERE household_members.household_id = recipes.household_id 
          AND household_members.user_id = auth.uid()
        )
      )
    )
  );

CREATE POLICY "Recipe owners can manage ingredients" ON recipe_ingredients
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM recipes 
      WHERE recipes.id = recipe_ingredients.recipe_id
      AND recipes.user_id = auth.uid()
    )
  );

-- Inventory items policies
CREATE POLICY "Household members can view inventory" ON inventory_items
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM household_members 
      WHERE household_members.household_id = inventory_items.household_id 
      AND household_members.user_id = auth.uid()
    )
  );

CREATE POLICY "Household members can manage inventory" ON inventory_items
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM household_members 
      WHERE household_members.household_id = inventory_items.household_id 
      AND household_members.user_id = auth.uid()
    )
  );

-- Receipts policies
CREATE POLICY "Users can view own and household receipts" ON receipts
  FOR SELECT USING (
    user_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM household_members 
      WHERE household_members.household_id = receipts.household_id 
      AND household_members.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can create receipts" ON receipts
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Receipt owners can update" ON receipts
  FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "Receipt owners can delete" ON receipts
  FOR DELETE USING (user_id = auth.uid());

-- Receipt items policies
CREATE POLICY "Users can view items of accessible receipts" ON receipt_items
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM receipts 
      WHERE receipts.id = receipt_items.receipt_id
      AND (
        receipts.user_id = auth.uid() OR
        EXISTS (
          SELECT 1 FROM household_members 
          WHERE household_members.household_id = receipts.household_id 
          AND household_members.user_id = auth.uid()
        )
      )
    )
  );

CREATE POLICY "Receipt owners can manage items" ON receipt_items
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM receipts 
      WHERE receipts.id = receipt_items.receipt_id
      AND receipts.user_id = auth.uid()
    )
  );

-- Mila interactions policies
CREATE POLICY "Users can view own interactions" ON mila_interactions
  FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Users can create interactions" ON mila_interactions
  FOR INSERT WITH CHECK (user_id = auth.uid());

-- Savings opportunities policies
CREATE POLICY "Users can view own and household savings" ON savings_opportunities
  FOR SELECT USING (
    user_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM household_members 
      WHERE household_members.household_id = savings_opportunities.household_id 
      AND household_members.user_id = auth.uid()
    )
  );

CREATE POLICY "System can create savings" ON savings_opportunities
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Users can update own savings" ON savings_opportunities
  FOR UPDATE USING (user_id = auth.uid());

-- User preferences policies
CREATE POLICY "Users can view own preferences" ON user_preferences
  FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Users can manage own preferences" ON user_preferences
  FOR ALL USING (user_id = auth.uid());

-- Analytics events policies
CREATE POLICY "Users can create own events" ON analytics_events
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can view own events" ON analytics_events
  FOR SELECT USING (user_id = auth.uid());

-- Shared lists policies
CREATE POLICY "List owners can share" ON shared_lists
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM shopping_lists 
      WHERE shopping_lists.id = shared_lists.shopping_list_id 
      AND shopping_lists.user_id = auth.uid()
    )
  );

CREATE POLICY "Involved users can view shares" ON shared_lists
  FOR SELECT USING (
    shared_with_user_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM shopping_lists 
      WHERE shopping_lists.id = shared_lists.shopping_list_id 
      AND shopping_lists.user_id = auth.uid()
    )
  );

CREATE POLICY "List owners can manage shares" ON shared_lists
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM shopping_lists 
      WHERE shopping_lists.id = shared_lists.shopping_list_id 
      AND shopping_lists.user_id = auth.uid()
    )
  );