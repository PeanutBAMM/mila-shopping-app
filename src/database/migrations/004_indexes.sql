-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS cube;
CREATE EXTENSION IF NOT EXISTS earthdistance;

-- Shopping list indexes
CREATE INDEX IF NOT EXISTS idx_shopping_lists_user_active ON shopping_lists(user_id, is_active);
CREATE INDEX IF NOT EXISTS idx_shopping_lists_household ON shopping_lists(household_id);
CREATE INDEX IF NOT EXISTS idx_shopping_lists_store ON shopping_lists(store_id);

-- Shopping items indexes
CREATE INDEX IF NOT EXISTS idx_shopping_items_list ON shopping_items(shopping_list_id);
CREATE INDEX IF NOT EXISTS idx_shopping_items_purchased ON shopping_items(shopping_list_id, is_purchased);
CREATE INDEX IF NOT EXISTS idx_shopping_items_product ON shopping_items(product_id);

-- Products indexes
CREATE INDEX IF NOT EXISTS idx_products_barcode ON products(barcode);
CREATE INDEX IF NOT EXISTS idx_products_name_trgm ON products USING gin(name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);

-- Product prices indexes
CREATE INDEX IF NOT EXISTS idx_product_prices_product_store ON product_prices(product_id, store_id);
CREATE INDEX IF NOT EXISTS idx_product_prices_validity ON product_prices(valid_from, valid_until);

-- Stores indexes
CREATE INDEX IF NOT EXISTS idx_stores_location ON stores USING gist(ll_to_earth(latitude, longitude));
CREATE INDEX IF NOT EXISTS idx_stores_city ON stores(city);
CREATE INDEX IF NOT EXISTS idx_stores_chain ON stores(chain);

-- Recipes indexes
CREATE INDEX IF NOT EXISTS idx_recipes_user ON recipes(user_id);
CREATE INDEX IF NOT EXISTS idx_recipes_household ON recipes(household_id);
CREATE INDEX IF NOT EXISTS idx_recipes_meal_type ON recipes(meal_type);
CREATE INDEX IF NOT EXISTS idx_recipes_name_trgm ON recipes USING gin(name gin_trgm_ops);

-- Recipe ingredients indexes
CREATE INDEX IF NOT EXISTS idx_recipe_ingredients_recipe ON recipe_ingredients(recipe_id);
CREATE INDEX IF NOT EXISTS idx_recipe_ingredients_product ON recipe_ingredients(product_id);

-- Inventory indexes
CREATE INDEX IF NOT EXISTS idx_inventory_household ON inventory_items(household_id);
CREATE INDEX IF NOT EXISTS idx_inventory_expiry ON inventory_items(expiry_date);
CREATE INDEX IF NOT EXISTS idx_inventory_location ON inventory_items(location);

-- Receipts indexes
CREATE INDEX IF NOT EXISTS idx_receipts_user ON receipts(user_id);
CREATE INDEX IF NOT EXISTS idx_receipts_household ON receipts(household_id);
CREATE INDEX IF NOT EXISTS idx_receipts_store ON receipts(store_id);
CREATE INDEX IF NOT EXISTS idx_receipts_date ON receipts(receipt_date);

-- Receipt items indexes
CREATE INDEX IF NOT EXISTS idx_receipt_items_receipt ON receipt_items(receipt_id);
CREATE INDEX IF NOT EXISTS idx_receipt_items_product ON receipt_items(product_id);

-- Household members indexes
CREATE INDEX IF NOT EXISTS idx_household_members_household ON household_members(household_id);
CREATE INDEX IF NOT EXISTS idx_household_members_user ON household_members(user_id);

-- Savings opportunities indexes
CREATE INDEX IF NOT EXISTS idx_savings_user ON savings_opportunities(user_id);
CREATE INDEX IF NOT EXISTS idx_savings_household ON savings_opportunities(household_id);
CREATE INDEX IF NOT EXISTS idx_savings_validity ON savings_opportunities(valid_until);
CREATE INDEX IF NOT EXISTS idx_savings_used ON savings_opportunities(is_used);

-- Mila interactions indexes
CREATE INDEX IF NOT EXISTS idx_mila_user ON mila_interactions(user_id);
CREATE INDEX IF NOT EXISTS idx_mila_type ON mila_interactions(type);
CREATE INDEX IF NOT EXISTS idx_mila_created ON mila_interactions(created_at);

-- Analytics events indexes
CREATE INDEX IF NOT EXISTS idx_analytics_user ON analytics_events(user_id);
CREATE INDEX IF NOT EXISTS idx_analytics_event ON analytics_events(event_name);
CREATE INDEX IF NOT EXISTS idx_analytics_created ON analytics_events(created_at);

-- Shared lists indexes
CREATE INDEX IF NOT EXISTS idx_shared_lists_list ON shared_lists(shopping_list_id);
CREATE INDEX IF NOT EXISTS idx_shared_lists_shared_with ON shared_lists(shared_with_user_id);

-- Product suggestions indexes
CREATE INDEX IF NOT EXISTS idx_product_suggestions_category ON product_suggestions(category);
CREATE INDEX IF NOT EXISTS idx_product_suggestions_name_trgm ON product_suggestions USING gin(name gin_trgm_ops);

-- Full text search indexes for Dutch
ALTER TABLE products ADD COLUMN IF NOT EXISTS search_vector tsvector;
CREATE INDEX IF NOT EXISTS idx_products_search ON products USING gin(search_vector);

ALTER TABLE recipes ADD COLUMN IF NOT EXISTS search_vector tsvector;
CREATE INDEX IF NOT EXISTS idx_recipes_search ON recipes USING gin(search_vector);

ALTER TABLE product_suggestions ADD COLUMN IF NOT EXISTS search_vector tsvector;
CREATE INDEX IF NOT EXISTS idx_product_suggestions_search ON product_suggestions USING gin(search_vector);

-- Update search vectors
UPDATE products SET search_vector = to_tsvector('dutch', coalesce(name, '') || ' ' || coalesce(brand, '') || ' ' || coalesce(category, ''));
UPDATE recipes SET search_vector = to_tsvector('dutch', coalesce(name, '') || ' ' || coalesce(description, '') || ' ' || coalesce(cuisine, ''));
UPDATE product_suggestions SET search_vector = to_tsvector('dutch', coalesce(name, '') || ' ' || coalesce(category, ''));

-- Create triggers to update search vectors
CREATE OR REPLACE FUNCTION update_products_search_vector()
RETURNS TRIGGER AS $$
BEGIN
  NEW.search_vector := to_tsvector('dutch', coalesce(NEW.name, '') || ' ' || coalesce(NEW.brand, '') || ' ' || coalesce(NEW.category, ''));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_recipes_search_vector()
RETURNS TRIGGER AS $$
BEGIN
  NEW.search_vector := to_tsvector('dutch', coalesce(NEW.name, '') || ' ' || coalesce(NEW.description, '') || ' ' || coalesce(NEW.cuisine, ''));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_product_suggestions_search_vector()
RETURNS TRIGGER AS $$
BEGIN
  NEW.search_vector := to_tsvector('dutch', coalesce(NEW.name, '') || ' ' || coalesce(NEW.category, ''));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_products_search_vector ON products;
CREATE TRIGGER update_products_search_vector BEFORE INSERT OR UPDATE ON products
  FOR EACH ROW EXECUTE FUNCTION update_products_search_vector();

DROP TRIGGER IF EXISTS update_recipes_search_vector ON recipes;
CREATE TRIGGER update_recipes_search_vector BEFORE INSERT OR UPDATE ON recipes
  FOR EACH ROW EXECUTE FUNCTION update_recipes_search_vector();

DROP TRIGGER IF EXISTS update_product_suggestions_search_vector ON product_suggestions;
CREATE TRIGGER update_product_suggestions_search_vector BEFORE INSERT OR UPDATE ON product_suggestions
  FOR EACH ROW EXECUTE FUNCTION update_product_suggestions_search_vector();