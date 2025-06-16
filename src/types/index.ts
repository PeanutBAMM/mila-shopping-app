import { Database } from './database.types';

// Re-export database types for convenience
export type { Database } from './database.types';

// Table types
export type Profile = Database['public']['Tables']['profiles']['Row'];
export type ShoppingList = Database['public']['Tables']['shopping_lists']['Row'];
export type ShoppingItem = Database['public']['Tables']['shopping_items']['Row'];
export type Store = Database['public']['Tables']['stores']['Row'];
export type Recipe = Database['public']['Tables']['recipes']['Row'];
export type RecipeIngredient = Database['public']['Tables']['recipe_ingredients']['Row'];
export type Receipt = Database['public']['Tables']['receipts']['Row'];
export type InventoryItem = Database['public']['Tables']['inventory_items']['Row'];
export type ProductSuggestion = Database['public']['Tables']['product_suggestions']['Row'];
export type Product = Database['public']['Tables']['products']['Row'];
export type MilaInteraction = Database['public']['Tables']['mila_interactions']['Row'];
export type UserPreferences = Database['public']['Tables']['user_preferences']['Row'];
export type Household = Database['public']['Tables']['households']['Row'];
export type HouseholdMember = Database['public']['Tables']['household_members']['Row'];

// Insert types
export type ProfileInsert = Database['public']['Tables']['profiles']['Insert'];
export type ShoppingListInsert = Database['public']['Tables']['shopping_lists']['Insert'];
export type ShoppingItemInsert = Database['public']['Tables']['shopping_items']['Insert'];
export type RecipeInsert = Database['public']['Tables']['recipes']['Insert'];

// Update types
export type ProfileUpdate = Database['public']['Tables']['profiles']['Update'];
export type ShoppingListUpdate = Database['public']['Tables']['shopping_lists']['Update'];
export type ShoppingItemUpdate = Database['public']['Tables']['shopping_items']['Update'];

// Enums
export type SubscriptionTier = 'free' | 'trial' | 'premium';
export type HouseholdRole = 'owner' | 'admin' | 'member';
export type InteractionType = 'suggestion' | 'voice_input' | 'chat' | 'savings_alert';
export type Location = 'fridge' | 'freezer' | 'pantry' | 'other';
export type Difficulty = 'easy' | 'medium' | 'hard';
export type MealType = 'breakfast' | 'lunch' | 'dinner' | 'snack';
export type SavingsType = 'deals' | 'coupons' | 'bulk' | 'price_match' | 'other';
export type Permission = 'view' | 'edit';

// Extended types with relationships
export interface ShoppingListWithItems extends ShoppingList {
  items?: ShoppingItem[];
  store?: Store;
}

export interface RecipeWithIngredients extends Recipe {
  ingredients?: RecipeIngredient[];
}

export interface ProfileWithPreferences extends Profile {
  preferences?: UserPreferences;
  household?: Household;
}

// App-specific types
export interface User {
  id: string;
  email?: string;
  profile?: Profile;
}

export interface AuthState {
  user: User | null;
  isLoading: boolean;
  isAuthenticated: boolean;
  isPremium: boolean;
  trialDaysLeft: number | null;
}