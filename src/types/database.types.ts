export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      achievements: {
        Row: {
          description: string | null
          earned_at: string | null
          id: string
          metadata: Json | null
          name: string
          type: string
          user_id: string
        }
        Insert: {
          description?: string | null
          earned_at?: string | null
          id?: string
          metadata?: Json | null
          name: string
          type: string
          user_id: string
        }
        Update: {
          description?: string | null
          earned_at?: string | null
          id?: string
          metadata?: Json | null
          name?: string
          type?: string
          user_id?: string
        }
        Relationships: []
      }
      household_members: {
        Row: {
          household_id: string
          id: string
          joined_at: string | null
          role: string
          user_id: string
        }
        Insert: {
          household_id: string
          id?: string
          joined_at?: string | null
          role: string
          user_id: string
        }
        Update: {
          household_id?: string
          id?: string
          joined_at?: string | null
          role?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "household_members_household_id_fkey"
            columns: ["household_id"]
            isOneToOne: false
            referencedRelation: "households"
            referencedColumns: ["id"]
          },
        ]
      }
      households: {
        Row: {
          created_at: string | null
          created_by: string
          id: string
          name: string
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          created_by: string
          id?: string
          name: string
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          created_by?: string
          id?: string
          name?: string
          updated_at?: string | null
        }
        Relationships: []
      }
      inventory_items: {
        Row: {
          barcode: string | null
          category: string | null
          created_at: string | null
          expiration_date: string | null
          id: string
          location: string | null
          low_stock_threshold: number | null
          name: string
          notes: string | null
          quantity: number | null
          unit: string | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          barcode?: string | null
          category?: string | null
          created_at?: string | null
          expiration_date?: string | null
          id?: string
          location?: string | null
          low_stock_threshold?: number | null
          name: string
          notes?: string | null
          quantity?: number | null
          unit?: string | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          barcode?: string | null
          category?: string | null
          created_at?: string | null
          expiration_date?: string | null
          id?: string
          location?: string | null
          low_stock_threshold?: number | null
          name?: string
          notes?: string | null
          quantity?: number | null
          unit?: string | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: []
      }
      list_shares: {
        Row: {
          accepted_at: string | null
          created_at: string | null
          id: string
          list_id: string
          permission: string | null
          share_token: string | null
          shared_with_email: string | null
          shared_with_user_id: string | null
        }
        Insert: {
          accepted_at?: string | null
          created_at?: string | null
          id?: string
          list_id: string
          permission?: string | null
          share_token?: string | null
          shared_with_email?: string | null
          shared_with_user_id?: string | null
        }
        Update: {
          accepted_at?: string | null
          created_at?: string | null
          id?: string
          list_id?: string
          permission?: string | null
          share_token?: string | null
          shared_with_email?: string | null
          shared_with_user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "list_shares_list_id_fkey"
            columns: ["list_id"]
            isOneToOne: false
            referencedRelation: "shopping_lists"
            referencedColumns: ["id"]
          },
        ]
      }
      meal_plans: {
        Row: {
          created_at: string | null
          id: string
          meal_type: string | null
          notes: string | null
          planned_date: string
          recipe_id: string | null
          servings: number | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          created_at?: string | null
          id?: string
          meal_type?: string | null
          notes?: string | null
          planned_date: string
          recipe_id?: string | null
          servings?: number | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          created_at?: string | null
          id?: string
          meal_type?: string | null
          notes?: string | null
          planned_date?: string
          recipe_id?: string | null
          servings?: number | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "meal_plans_recipe_id_fkey"
            columns: ["recipe_id"]
            isOneToOne: false
            referencedRelation: "recipes"
            referencedColumns: ["id"]
          },
        ]
      }
      mila_interactions: {
        Row: {
          created_at: string | null
          id: string
          interaction_type: string
          list_id: string | null
          metadata: Json | null
          mila_response: string | null
          user_id: string
          user_input: string | null
        }
        Insert: {
          created_at?: string | null
          id?: string
          interaction_type: string
          list_id?: string | null
          metadata?: Json | null
          mila_response?: string | null
          user_id: string
          user_input?: string | null
        }
        Update: {
          created_at?: string | null
          id?: string
          interaction_type?: string
          list_id?: string | null
          metadata?: Json | null
          mila_response?: string | null
          user_id?: string
          user_input?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "mila_interactions_list_id_fkey"
            columns: ["list_id"]
            isOneToOne: false
            referencedRelation: "shopping_lists"
            referencedColumns: ["id"]
          },
        ]
      }
      notification_settings: {
        Row: {
          created_at: string | null
          deal_alerts: boolean | null
          email_enabled: boolean | null
          expiry_reminders: boolean | null
          push_enabled: boolean | null
          reminder_time: string | null
          shopping_reminders: boolean | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          created_at?: string | null
          deal_alerts?: boolean | null
          email_enabled?: boolean | null
          expiry_reminders?: boolean | null
          push_enabled?: boolean | null
          reminder_time?: string | null
          shopping_reminders?: boolean | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          created_at?: string | null
          deal_alerts?: boolean | null
          email_enabled?: boolean | null
          expiry_reminders?: boolean | null
          push_enabled?: boolean | null
          reminder_time?: string | null
          shopping_reminders?: boolean | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: []
      }
      product_suggestions: {
        Row: {
          category: string
          created_at: string | null
          id: string
          name: string
          related_to: string[] | null
          typical_quantity: number | null
          typical_unit: string | null
        }
        Insert: {
          category: string
          created_at?: string | null
          id?: string
          name: string
          related_to?: string[] | null
          typical_quantity?: number | null
          typical_unit?: string | null
        }
        Update: {
          category?: string
          created_at?: string | null
          id?: string
          name?: string
          related_to?: string[] | null
          typical_quantity?: number | null
          typical_unit?: string | null
        }
        Relationships: []
      }
      products: {
        Row: {
          allergens: string[] | null
          barcode: string | null
          brand: string | null
          category: string | null
          created_at: string | null
          id: string
          name: string
          nutritional_info: Json | null
          typical_price: number | null
          unit: string | null
          updated_at: string | null
        }
        Insert: {
          allergens?: string[] | null
          barcode?: string | null
          brand?: string | null
          category?: string | null
          created_at?: string | null
          id?: string
          name: string
          nutritional_info?: Json | null
          typical_price?: number | null
          unit?: string | null
          updated_at?: string | null
        }
        Update: {
          allergens?: string[] | null
          barcode?: string | null
          brand?: string | null
          category?: string | null
          created_at?: string | null
          id?: string
          name?: string
          nutritional_info?: Json | null
          typical_price?: number | null
          unit?: string | null
          updated_at?: string | null
        }
        Relationships: []
      }
      profiles: {
        Row: {
          avatar_url: string | null
          created_at: string | null
          full_name: string | null
          household_id: string | null
          id: string
          stripe_customer_id: string | null
          subscription_tier: string | null
          trial_ends_at: string | null
          updated_at: string | null
          username: string | null
        }
        Insert: {
          avatar_url?: string | null
          created_at?: string | null
          full_name?: string | null
          household_id?: string | null
          id: string
          stripe_customer_id?: string | null
          subscription_tier?: string | null
          trial_ends_at?: string | null
          updated_at?: string | null
          username?: string | null
        }
        Update: {
          avatar_url?: string | null
          created_at?: string | null
          full_name?: string | null
          household_id?: string | null
          id?: string
          stripe_customer_id?: string | null
          subscription_tier?: string | null
          trial_ends_at?: string | null
          updated_at?: string | null
          username?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "profiles_household_id_fkey"
            columns: ["household_id"]
            isOneToOne: false
            referencedRelation: "households"
            referencedColumns: ["id"]
          },
        ]
      }
      receipts: {
        Row: {
          created_at: string | null
          id: string
          image_url: string | null
          list_id: string | null
          payment_method: string | null
          purchase_date: string | null
          savings_amount: number | null
          scanned_data: Json | null
          store_id: string | null
          store_name: string | null
          total_amount: number | null
          user_id: string
        }
        Insert: {
          created_at?: string | null
          id?: string
          image_url?: string | null
          list_id?: string | null
          payment_method?: string | null
          purchase_date?: string | null
          savings_amount?: number | null
          scanned_data?: Json | null
          store_id?: string | null
          store_name?: string | null
          total_amount?: number | null
          user_id: string
        }
        Update: {
          created_at?: string | null
          id?: string
          image_url?: string | null
          list_id?: string | null
          payment_method?: string | null
          purchase_date?: string | null
          savings_amount?: number | null
          scanned_data?: Json | null
          store_id?: string | null
          store_name?: string | null
          total_amount?: number | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "receipts_list_id_fkey"
            columns: ["list_id"]
            isOneToOne: false
            referencedRelation: "shopping_lists"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "receipts_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
        ]
      }
      recipe_favorites: {
        Row: {
          created_at: string | null
          recipe_id: string
          user_id: string
        }
        Insert: {
          created_at?: string | null
          recipe_id: string
          user_id: string
        }
        Update: {
          created_at?: string | null
          recipe_id?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "recipe_favorites_recipe_id_fkey"
            columns: ["recipe_id"]
            isOneToOne: false
            referencedRelation: "recipes"
            referencedColumns: ["id"]
          },
        ]
      }
      recipe_ingredients: {
        Row: {
          category: string | null
          id: string
          name: string
          notes: string | null
          optional: boolean | null
          position: number | null
          quantity: number | null
          recipe_id: string
          unit: string | null
        }
        Insert: {
          category?: string | null
          id?: string
          name: string
          notes?: string | null
          optional?: boolean | null
          position?: number | null
          quantity?: number | null
          recipe_id: string
          unit?: string | null
        }
        Update: {
          category?: string | null
          id?: string
          name?: string
          notes?: string | null
          optional?: boolean | null
          position?: number | null
          quantity?: number | null
          recipe_id?: string
          unit?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "recipe_ingredients_recipe_id_fkey"
            columns: ["recipe_id"]
            isOneToOne: false
            referencedRelation: "recipes"
            referencedColumns: ["id"]
          },
        ]
      }
      recipes: {
        Row: {
          cook_time: number | null
          created_at: string | null
          created_by: string | null
          cuisine: string | null
          description: string | null
          dietary_tags: string[] | null
          difficulty: string | null
          id: string
          image_url: string | null
          instructions: string[] | null
          is_public: boolean | null
          prep_time: number | null
          servings: number | null
          title: string
          updated_at: string | null
        }
        Insert: {
          cook_time?: number | null
          created_at?: string | null
          created_by?: string | null
          cuisine?: string | null
          description?: string | null
          dietary_tags?: string[] | null
          difficulty?: string | null
          id?: string
          image_url?: string | null
          instructions?: string[] | null
          is_public?: boolean | null
          prep_time?: number | null
          servings?: number | null
          title: string
          updated_at?: string | null
        }
        Update: {
          cook_time?: number | null
          created_at?: string | null
          created_by?: string | null
          cuisine?: string | null
          description?: string | null
          dietary_tags?: string[] | null
          difficulty?: string | null
          id?: string
          image_url?: string | null
          instructions?: string[] | null
          is_public?: boolean | null
          prep_time?: number | null
          servings?: number | null
          title?: string
          updated_at?: string | null
        }
        Relationships: []
      }
      savings_history: {
        Row: {
          amount: number
          created_at: string | null
          id: string
          percentage: number | null
          receipt_id: string | null
          savings_type: string | null
          store_id: string | null
          user_id: string
        }
        Insert: {
          amount: number
          created_at?: string | null
          id?: string
          percentage?: number | null
          receipt_id?: string | null
          savings_type?: string | null
          store_id?: string | null
          user_id: string
        }
        Update: {
          amount?: number
          created_at?: string | null
          id?: string
          percentage?: number | null
          receipt_id?: string | null
          savings_type?: string | null
          store_id?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "savings_history_receipt_id_fkey"
            columns: ["receipt_id"]
            isOneToOne: false
            referencedRelation: "receipts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "savings_history_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
        ]
      }
      shopping_items: {
        Row: {
          added_by: string | null
          category: string | null
          checked_at: string | null
          created_at: string | null
          id: string
          is_checked: boolean | null
          list_id: string
          name: string
          notes: string | null
          position: number | null
          price: number | null
          product_id: string | null
          quantity: number | null
          unit: string | null
          updated_at: string | null
        }
        Insert: {
          added_by?: string | null
          category?: string | null
          checked_at?: string | null
          created_at?: string | null
          id?: string
          is_checked?: boolean | null
          list_id: string
          name: string
          notes?: string | null
          position?: number | null
          price?: number | null
          product_id?: string | null
          quantity?: number | null
          unit?: string | null
          updated_at?: string | null
        }
        Update: {
          added_by?: string | null
          category?: string | null
          checked_at?: string | null
          created_at?: string | null
          id?: string
          is_checked?: boolean | null
          list_id?: string
          name?: string
          notes?: string | null
          position?: number | null
          price?: number | null
          product_id?: string | null
          quantity?: number | null
          unit?: string | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "shopping_items_list_id_fkey"
            columns: ["list_id"]
            isOneToOne: false
            referencedRelation: "shopping_lists"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "shopping_items_product_id_fkey"
            columns: ["product_id"]
            isOneToOne: false
            referencedRelation: "products"
            referencedColumns: ["id"]
          },
        ]
      }
      shopping_lists: {
        Row: {
          completed_at: string | null
          created_at: string | null
          id: string
          is_active: boolean | null
          name: string
          store_id: string | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          completed_at?: string | null
          created_at?: string | null
          id?: string
          is_active?: boolean | null
          name: string
          store_id?: string | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          completed_at?: string | null
          created_at?: string | null
          id?: string
          is_active?: boolean | null
          name?: string
          store_id?: string | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "shopping_lists_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
        ]
      }
      stores: {
        Row: {
          address: string | null
          chain: string | null
          city: string | null
          created_at: string | null
          id: string
          latitude: number | null
          longitude: number | null
          name: string
          postal_code: string | null
        }
        Insert: {
          address?: string | null
          chain?: string | null
          city?: string | null
          created_at?: string | null
          id?: string
          latitude?: number | null
          longitude?: number | null
          name: string
          postal_code?: string | null
        }
        Update: {
          address?: string | null
          chain?: string | null
          city?: string | null
          created_at?: string | null
          id?: string
          latitude?: number | null
          longitude?: number | null
          name?: string
          postal_code?: string | null
        }
        Relationships: []
      }
      user_preferences: {
        Row: {
          budget_weekly: number | null
          created_at: string | null
          dietary_restrictions: string[] | null
          language: string | null
          mila_personality: string | null
          notifications_enabled: boolean | null
          preferred_stores: string[] | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          budget_weekly?: number | null
          created_at?: string | null
          dietary_restrictions?: string[] | null
          language?: string | null
          mila_personality?: string | null
          notifications_enabled?: boolean | null
          preferred_stores?: string[] | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          budget_weekly?: number | null
          created_at?: string | null
          dietary_restrictions?: string[] | null
          language?: string | null
          mila_personality?: string | null
          notifications_enabled?: boolean | null
          preferred_stores?: string[] | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      calculate_user_savings: {
        Args: { user_uuid: string; period_days?: number }
        Returns: {
          total_savings: number
          savings_count: number
          average_savings: number
        }[]
      }
      find_stores_near: {
        Args: { lat: number; lng: number; radius_km?: number }
        Returns: {
          store_id: string
          store_name: string
          distance_km: number
        }[]
      }
      generate_share_token: {
        Args: Record<PropertyKey, never>
        Returns: string
      }
      get_expiring_items: {
        Args: { user_uuid: string; days_ahead?: number }
        Returns: {
          item_name: string
          expiration_date: string
          days_until_expiration: number
          location: string
        }[]
      }
      get_list_statistics: {
        Args: { list_uuid: string }
        Returns: {
          total_items: number
          checked_items: number
          total_price: number
          completion_percentage: number
        }[]
      }
      has_premium_access: {
        Args: { user_uuid: string }
        Returns: boolean
      }
      suggest_shopping_items: {
        Args: { user_uuid: string; limit_count?: number }
        Returns: {
          item_name: string
          frequency: number
          last_purchased: string
          average_quantity: number
        }[]
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DefaultSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof Database },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends { schema: keyof Database }
  ? Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never