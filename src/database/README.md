# Database Structure

This directory contains all database migrations for the Mila shopping app.

## Tables

### Core Tables
- `profiles` - User profiles with subscription info
- `households` - Household management
- `household_members` - Members of households
- `user_preferences` - User preferences and settings

### Shopping Lists
- `shopping_lists` - Shopping lists
- `shopping_items` - Items in shopping lists
- `shared_lists` - Shared shopping lists

### Products & Stores
- `stores` - Store locations
- `products` - Product catalog
- `product_suggestions` - AI-powered product suggestions
- `product_prices` - Price tracking

### Recipes
- `recipes` - Recipe collection
- `recipe_ingredients` - Ingredients for recipes

### Inventory & Receipts
- `inventory_items` - Household inventory tracking
- `receipts` - Scanned receipts
- `receipt_items` - Items from receipts

### AI & Analytics
- `mila_interactions` - AI assistant interactions
- `savings_opportunities` - Identified savings
- `analytics_events` - User analytics

## Functions

- `handle_new_user()` - Sets up new users with 30-day trial
- `is_premium_user()` - Checks if user has premium access
- `days_until_trial_ends()` - Calculates remaining trial days
- `calculate_total_savings()` - Calculates user savings

## RLS Policies

All tables have Row Level Security enabled with appropriate policies for:
- User data isolation
- Household data sharing
- Shopping list sharing

## Storage Buckets

- `receipts` - Receipt images
- `recipes` - Recipe images
- `avatars` - User avatars
- `products` - Product images